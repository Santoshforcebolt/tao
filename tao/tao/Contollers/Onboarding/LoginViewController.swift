//
//  LoginViewController.swift
//  tao
//
//  Created by Betto Akkara on 06/02/22.
//

import UIKit


class LoginViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var flag_img: UIImageView!
    @IBOutlet weak var country_code: UILabel!
    @IBOutlet weak var bottomConst: NSLayoutConstraint!
    @IBOutlet weak var mobile_number: UITextField!
    @IBOutlet weak var next_btn: TaoButton!

    @IBOutlet weak var lblPrivacyTerm: UILabel!
    
    let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TextField Delegate
        mobile_number.delegate = self
        // Setting Current Country
        let country = Country.getCurrentCountry()!
        country_code.text = country.dialCode!
        flag_img.image = UIImage(named: country.code.uppercased())
        // Notifications for Keyboard Activity
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        next_btn.isActive = false

        setupMultipleTapLabel()

    }


    let fullString = "By continuing, you agree to the Terms of Service and Privacy Policy"

    func setupMultipleTapLabel() {
        let underlineAttriString = NSMutableAttributedString(string: fullString)
        let termsRange = ((fullString).range(of: "Terms of Service")?.nsRange(in: fullString))!
        let privacyRange = ((fullString).range(of: "Privacy Policy")?.nsRange(in: fullString))!

        underlineAttriString.addAttribute(.foregroundColor, value: UIColor.TAO_Link, range: termsRange)
        underlineAttriString.addAttribute(.foregroundColor, value: UIColor.TAO_Link, range: privacyRange)

            lblPrivacyTerm.attributedText = underlineAttriString
            let tapAction = UITapGestureRecognizer(target: self, action: #selector(self.tapLabel(gesture:)))
            lblPrivacyTerm.isUserInteractionEnabled = true
            lblPrivacyTerm.addGestureRecognizer(tapAction)
        }

    @objc func tapLabel(gesture: UITapGestureRecognizer) {
        let termsRange = (fullString as NSString).range(of: "Terms of Service")
        let privacyRange = (fullString as NSString).range(of: "Privacy Policy")
        if gesture.didTapAttributedTextInLabel(label: lblPrivacyTerm, inRange: termsRange) {
            print("Tapped targetRange1")
        } else if gesture.didTapAttributedTextInLabel(label: lblPrivacyTerm, inRange: privacyRange) {
            print("Tapped targetRange2")
        } else {}
    }
    @IBAction func showCtryList(_ sender: Any) {
        Logger.d(Locale.current.identifier)
        
        let controller = DialCountriesController(locale:  Locale(identifier: countryCode ?? "IN"))
        controller.delegate = self
        controller.show(vc: self)
        
    }
    @IBAction func next_btn_click(_ sender: Any) {


        let phone = self.mobile_number.text ?? ""
   
        APIDataProvider.init().getOtp(urlParams: ["phone":phone]) { response in

            if response != ""{
                DispatchQueue.main.async {
                    self.view.endEditing(true)
                    TaoHelper.delay(0.3) {
                        guard let ob_vc = self.storyboard?.instantiateViewController(withIdentifier: "EnterOtpViewController") as? EnterOtpViewController else {
                            return
                        }
                        ob_vc.phoneNumber = phone
                        ob_vc.countryCode = self.country_code.text
                        self.navigationController?.pushViewController(ob_vc, animated: true)
                    }
                }

            }else{
                DispatchQueue.main.async {
                    self.view.makeToast("Something went wrong, try after sometime...")
                }

            }

        } onError: { error in
            DispatchQueue.main.async {
                self.view.makeToast("Oops!!! \nSomething went wrong, try after sometime...")
                Logger.d(error)
            }
        }



    }

    
    //MARK: - getKayboardHeight
    @objc func keyboardWillShow(notification: Notification) {
        DispatchQueue.main.async {
            let userInfo:NSDictionary = notification.userInfo! as NSDictionary
            let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            // do whatever you want with this keyboard height
            self.bottomConst.constant = keyboardHeight
        }
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        // keyboard is dismissed/hidden from the screen
        DispatchQueue.main.async {
            self.bottomConst.constant = 40
        }
        
    }
    
}

extension LoginViewController: DialCountriesControllerDelegate {
    
    func didSelected(with country: Country) {
        country_code.text = country.dialCode!
        flag_img.image = UIImage(named: country.code.uppercased())
    }
    
}


extension LoginViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField.text!.count > 4){
            self.next_btn.isActive = true
        }else{
            self.next_btn.isActive = false
        }
        
        return string == "" ? true :(textField.text!.count > 16 ? false : true)
        
        
    }
    
}
