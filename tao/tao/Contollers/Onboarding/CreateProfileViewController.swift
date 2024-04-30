//
//  CreateProfileViewController.swift
//  tao
//
//  Created by Betto Akkara on 10/02/22.
//

import UIKit


class CreateProfileViewController: UIViewController {

    @IBOutlet weak var back: UIButton!
    
    @IBOutlet weak var referal_txt: TaoTextField!
    @IBOutlet weak var date_txt: TaoTextField!
    @IBOutlet weak var name_txt: TaoTextField!
    
    
    @IBOutlet weak var continue_btn: TaoButton!
    
    @IBOutlet weak var boy_view: UIView!
    @IBOutlet weak var boy_lbl: UILabel!
    @IBOutlet weak var boy_img: UIImageView!
    
    @IBOutlet weak var girl_view: UIView!
    @IBOutlet weak var girl_lbl: UILabel!
    @IBOutlet weak var girl_img: UIImageView!
    
    @IBOutlet weak var other_view: UIView!
    @IBOutlet weak var other_lbl: UILabel!
    @IBOutlet weak var other_img: UIImageView!
    
    var userID: String?
    
    var selected_gender : Gender? = nil
    
    enum Gender : String{
        case boy = "MALE"
        case girl = "FEMALE"
        case other = "OTHER"
    }
    enum Section{
        case name
        case date
        case gender
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func back(_ sender: Any) {
        (self.navigationController as? TaoNavigationController)?.popToViewController(ofClass: LoginViewController.self)
    }
    
    @IBAction func continue_OnClick(_ sender: Any) {
        let validat_resp = self.validateFields()
        if validat_resp.isValid {

            let name = self.name_txt.text?.split(separator: " ")
            createProfile.firstName = "\(name![0])"
            createProfile.lastName = name?.count ?? 0 > 1 ? "\(name![1])" : ""
            createProfile.referredBy = self.referal_txt.text ?? ""
            createProfile.gender = self.selected_gender?.rawValue ?? ""

//            BALoader.show(currentViewController: self, color: .TAO_Link)
//
//            print(createProfile)

//            TaoHelper.delay(0.3) {
//                BALoader.dismiss(currentViewController: self)

                guard let pvc = self.storyboard?.instantiateViewController(withIdentifier: "EnterSchoolDetailsViewController") as? EnterSchoolDetailsViewController else {
                    return
                }
            pvc.userID = self.userID

                self.navigationController?.pushViewController(pvc, animated: true)
//            }
        }else{
            self.view.makeToast("Please fill all the mandatory fields")
            switch validat_resp.section.first! {
            case .name:
                self.name_txt.becomeFirstResponder()
                break
            case .date, .gender:
                break
            }
        }
    }
    func showCalendar() {
           
           let calenderView = BACalenderView
           // Here we are setting delegate
           calenderView.calendarDelegate = self
           // here, you can change the theme
        calenderView.themeColor = UIColor.TAO_Link
           // here you can configure your BACalneder
           let startDate = Helper.calendarAdvanced(byAdding: .year, value: -100, startDate: Date())
           let endDate = Date()
           calenderView.configureCalender(
               startDate: startDate,
               endDate: endDate,
               selectedDate: endDate
           )
           
           PopupContainer.generatePopupWithView(calenderView).show()

    }
    @IBAction func calendar_OnClick(_ sender: Any) {
        showCalendar()
    }
    
    @IBAction func select_boy(_ sender: Any) {
        self.setGender(.boy)
    }
    
    @IBAction func select_girl(_ sender: Any) {
        self.setGender(.girl)
    }
    
    @IBAction func select_other(_ sender: Any) {
        self.setGender(.other)
    }
}

extension CreateProfileViewController : CalendarPopUpDelegate{
    func dateChaged(date: Date) {
        
        self.date_txt.text = DateConverter.convertDateFormat(date, outputFormat: "dd/MM/yyyy")
        createProfile.dateOfBirth = DateConverter.convertDateFormat(date, outputFormat: "yyyy-MM-dd'T'HH:mm:ss") //  "dateOfBirth": "2022-03-06T20:28:37.192Z"
    }
    
    
}


//MARK: Validate Fields
extension CreateProfileViewController {
    
    func validateFields() -> (section : [Section],isValid : Bool) {
        
        if self.name_txt.text?.isEmpty ?? false {
             return ([.name],false)
        }else if self.date_txt.text?.isEmpty ?? false  {
            return ([.date],false)
        }else if self.selected_gender == nil{
            return ([.gender],false)
        }else{
            return ([],true)
        }
        
    }
    
}
//MARK: Set-Gender
extension CreateProfileViewController {
    
    func setGender(_ gender : Gender) {
        
        self.selected_gender = gender

        createProfile.gender = gender.rawValue


        switch gender {
        case .boy:
            
            
            boy_view.layer.backgroundColor = UIColor.TAO_E0F0FF.cgColor
            boy_view.layer.borderWidth = 1
            boy_view.layer.borderColor = UIColor.TAO_4F9DEB.cgColor
            
            girl_view.layer.backgroundColor = UIColor.TAO_LightGray3.cgColor
            girl_view.layer.borderWidth = 0
            
            other_view.layer.backgroundColor = UIColor.TAO_LightGray3.cgColor
            other_view.layer.borderWidth = 0
            
            
            boy_lbl.textColor = UIColor.TAO_1E668E
            boy_img.tintColor = UIColor.TAO_1E668E
            
            girl_lbl.textColor = UIColor.TAO_Black
            girl_img.tintColor = UIColor.TAO_Black
            
            other_lbl.textColor = UIColor.TAO_Black
            other_img.tintColor = UIColor.TAO_Black
            
            
            break
        case .girl:
            girl_view.layer.backgroundColor = UIColor.TAO_E0F0FF.cgColor
            girl_view.layer.borderWidth = 1
            girl_view.layer.borderColor = UIColor.TAO_4F9DEB.cgColor
            
            boy_view.layer.backgroundColor = UIColor.TAO_LightGray3.cgColor
            boy_view.layer.borderWidth = 0
            
            other_view.layer.backgroundColor = UIColor.TAO_LightGray3.cgColor
            other_view.layer.borderWidth = 0
            
            
            boy_lbl.textColor = UIColor.TAO_Black
            boy_img.tintColor = UIColor.TAO_Black
            
            girl_lbl.textColor = UIColor.TAO_1E668E
            girl_img.tintColor = UIColor.TAO_1E668E
            
            other_lbl.textColor = UIColor.TAO_Black
            other_img.tintColor = UIColor.TAO_Black
            
            
            break
        case .other:
            other_view.layer.backgroundColor = UIColor.TAO_E0F0FF.cgColor
            other_view.layer.borderWidth = 1
            other_view.layer.borderColor = UIColor.TAO_4F9DEB.cgColor
            
            girl_view.layer.backgroundColor = UIColor.TAO_LightGray3.cgColor
            girl_view.layer.borderWidth = 0
            
            boy_view.layer.backgroundColor = UIColor.TAO_LightGray3.cgColor
            boy_view.layer.borderWidth = 0
            
            
            
            boy_lbl.textColor = UIColor.TAO_Black
            boy_img.tintColor = UIColor.TAO_Black
            
            girl_lbl.textColor = UIColor.TAO_Black
            girl_img.tintColor = UIColor.TAO_Black
            
            other_lbl.textColor = UIColor.TAO_1E668E
            other_img.tintColor = UIColor.TAO_1E668E
            
            break
        }
    
    }
    
}
