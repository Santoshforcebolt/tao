//
//  EnterOtpViewController.swift
//  tao
//
//  Created by Betto Akkara on 08/02/22.
//

import Foundation
import UIKit
import Alamofire

class EnterOtpViewController : UIViewController{

    @IBOutlet weak var otpInstruction: UILabel!
    @IBOutlet var pinTxtFields: [UITextField]!
    @IBOutlet var next_btn : TaoButton!
    @IBOutlet weak var resend_otp: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var errorImg: UIImageView!
    @IBOutlet weak var bottom_const: NSLayoutConstraint!

    var pinEntered : [String] = []
    var phoneNumber: String?
    var countryCode: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        let otpInstructionString = "We have sent 4 digit OTP on this number \(self.countryCode ?? "") \(self.phoneNumber ?? ""). Enter it below"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Bold", size: 17)]
        let otpInstructionText = NSMutableAttributedString(string: otpInstructionString)
        let lengthForBoldText = ((self.countryCode?.count ?? 0) + (self.phoneNumber?.count ?? 0)) 
        otpInstructionText.addAttributes(attributes as [NSAttributedString.Key : Any],
                                         range: NSRange(location: 40,
                                                        length: lengthForBoldText == 0 ? 0 : lengthForBoldText + 1))
        self.otpInstruction.attributedText = otpInstructionText
        self.pinTxtFields.forEach { textField in
            textField.delegate = self
        }
        self.isProceedEnabled()
        self.errorMessage(isEnabled: false)


        // Notifications for Keyboard Activity
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)

    }
  
    func errorMessage(isEnabled : Bool) {
        switch isEnabled{
            
        case true:
            self.errorMessage.isHidden = false
            self.errorImg.isHidden = false
        case false:
            self.errorMessage.isHidden = true
            self.errorImg.isHidden = true
        }

    }
    @IBAction func back()
    {

        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func pinFieldAction(_ sender: Any) {

        loop: for textField_ in self.pinTxtFields.enumerated()
        {
            if textField_.element.text?.isEmpty == true || textField_.element.text == "" {
                let _ = self.pinTxtFields[textField_.offset == 0 ? 0 : (textField_.offset == 5 ? 5 : textField_.offset-1)].becomeFirstResponder()
                break loop;
            }else{
                if (textField_.offset == 5){
                    let _ = self.pinTxtFields[textField_.offset == 0 ? 0 : (textField_.offset == 5 ? 5 : textField_.offset-1)].becomeFirstResponder()
                }
            }
        }

    }

    @IBAction func next_btn(_ sender: Any) {

        BALoader.show(currentViewController: self, color: .TAO_Link)

        let opt = self.pinEntered.joined(separator: "")
        let phone = self.phoneNumber

        let param = ["otp":opt,"phone":phone]

//        let headers = Alamofire.HTTPHeaders(coreHeaders())
//        AF.request("\(AppController.shared.getBaseURL())api/login/otp/validate",
//                   method: .post,
//                   parameters: param,
//                   headers: headers).responseJSON { response in
//            
//            print(response.data)
//            print(response.result)
//            print(response.error)
//            print(response.value)
//        }
        
        APIDataProvider.init().validateOtp(bodyParams: param) { response in

            BALoader.dismiss(currentViewController: self)
            if response?.success == true{

                //MARK: Save User state if OTP Validated is successful
                if let phone = phone,
                   let token = response?.token,
                   let refreshToken = response?.refreshToken,
                   let userId = response?.userID {
                    AppController.shared.saveUserState(phone: phone,
                                                       token: token,
                                                       refreshToken: refreshToken,
                                                       userId: userId)
                }

                if response?.profileCreated == true{

                    DispatchQueue.main.async {
                        let parentVC = ParentViewController()
                        self.navigationController?.pushViewController(parentVC, animated: true)
                    }

                }else{

                    TaoHelper.delay(0.4) {
                        guard let pvc = self.storyboard?.instantiateViewController(withIdentifier: "CreateProfileViewController") as? CreateProfileViewController else {
                            return
                        }
                        pvc.userID = response?.userID
                        self.navigationController?.pushViewController(pvc, animated: true)
                    }

                }


            }else{
                DispatchQueue.main.async {
                    self.view.makeToast("Something went wrong, try after sometime...")
                }
            }

        } onError: { error in
            Logger.w(error)
            DispatchQueue.main.async {
                self.view.makeToast("Something went wrong, try after sometime...\n\(error)")
            }

        }

    }


    func isProceedEnabled()
    {
        self.next_btn.isActive = ((pinEntered.count == 6) ? true : false)
    }



    //MARK: - getKayboardHeight
    @objc func keyboardWillShow(notification: Notification) {
        DispatchQueue.main.async {
            let userInfo:NSDictionary = notification.userInfo! as NSDictionary
            let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            // do whatever you want with this keyboard height
            self.bottom_const.constant = keyboardHeight + 20
        }

    }

    @objc func keyboardWillHide(notification: Notification) {
        // keyboard is dismissed/hidden from the screen
        DispatchQueue.main.async {
            self.bottom_const.constant = 20
        }

    }

}

extension EnterOtpViewController : UITextFieldDelegate{


    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        Logger.d(string)

        if self.pinTxtFields.contains(textField ){
            guard let currentIndex = self.pinTxtFields.firstIndex(of: textField ) else { return true}
            if string != ""
            {


                if self.pinTxtFields[currentIndex].text == ""{
                    self.pinTxtFields[currentIndex].text = string
                    pinEntered.append(string)
                }else{
                    if self.pinTxtFields.count > currentIndex+1{
                        let _ = self.pinTxtFields[currentIndex+1].becomeFirstResponder()
                        self.pinTxtFields[currentIndex+1].text = string
                        pinEntered.append(string)
                    }
                }
            }else{
                self.pinTxtFields[currentIndex].text = string
                if (!pinEntered.isEmpty){
                    pinEntered.removeLast()
                }
                if (currentIndex-1 >= 0){
                    let _ = self.pinTxtFields[currentIndex-1].becomeFirstResponder()
                }
            }
            self.isProceedEnabled()
            return false

        }else{
            self.isProceedEnabled()
            return false

        }

    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.isProceedEnabled()

    }



}

