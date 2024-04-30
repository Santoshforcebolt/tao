//
//  EnterSchoolDetailsViewController.swift
//  tao
//
//  Created by Betto Akkara on 15/02/22.
//

import UIKit

class EnterSchoolDetailsViewController: UIViewController {

    @IBOutlet weak var school_txt: DropDown!
    @IBOutlet weak var class_txt: DropDown!
    @IBOutlet weak var city_txt: DropDown!

    
    var searchLocations: [SearchLocationElement]?
    
    var userID: String?
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        let schoolInfo = SchoolInfo()
        schoolInfo.schoolID = ""
        schoolInfo.schoolName = self.school_txt.text
        schoolInfo.standard = self.class_txt.text
        createProfile.schoolInfo = schoolInfo
        
        let location: SearchLocationElement? = self.searchLocations?[self.city_txt.selectedIndex ?? 0]
        
        let schoolInfoForCreate = SchoolInfoForCreate()
        schoolInfoForCreate.city = self.city_txt.text
        schoolInfoForCreate.schoolName = createProfile.schoolInfo?.schoolName
        schoolInfoForCreate.standard = createProfile.schoolInfo?.standard
        schoolInfoForCreate.locationId = location?.id ?? ""
        schoolInfoForCreate.pin = location?.pin ?? ""
        schoolInfoForCreate.state = location?.state ?? ""
        
        let xparams: HTTPBody = ["firstName": createProfile.firstName ?? "",
                      "lastName": createProfile.lastName ?? "",
                      "referredBy": createProfile.referredBy,
                                 "id": self.userID ?? "",
                                 "gender": createProfile.gender?.lowercased() ?? "",
                                 "schoolInfo": ["city" : schoolInfoForCreate.city, "schoolName": schoolInfoForCreate.schoolName, "standard": schoolInfoForCreate.standard, "locationId" : schoolInfoForCreate.locationId, "pin": schoolInfoForCreate.pin, "state": schoolInfoForCreate.state],
                      "dateOfBirth": createProfile.dateOfBirth ?? ""
        ]
        
        TaoHelper.userID = self.userID
        
        let paramSchool = ["city": schoolInfoForCreate.city ?? "",
                           "name": createProfile.schoolInfo?.schoolName ?? "",
                           "locationId" : schoolInfoForCreate.locationId ?? "",
                           "pin": schoolInfoForCreate.pin ?? ""]
        
        ApiProviderImpl.instance.profileApi.createSchool(params: paramSchool as [String : Any]) { _, error in
            if error == nil {
                APIDataProvider.init().user_create(bodyParams: xparams) { success in
                    DispatchQueue.main.async {
                        let parentVC = ParentViewController()
                        self.navigationController?.pushViewController(parentVC, animated: true)
                    }
                } onError: { error in
                    print(error?.debugDescription)
                }
            }
        }
        
//        APIDataProvider.init().school_create(bodyParams: paramSchool as HTTPBody) { success in
//
//
//        } onError: { error in
//            print(error?.debugDescription)
//        }

        
//        APIDataProvider.init().user_create(bodyParams: params) { success in
//            DispatchQueue.main.async {
//                guard let ob_vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeParentViewController") as? HomeParentViewController else {
//                    return
//                }
//                self.navigationController?.pushViewController(ob_vc, animated: true)
//            }
//        } onError: { error in
//            print(error?.debugDescription)
//        }

    }
    
    var countDownTime = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        city_txt.delegate = self
        class_txt.delegate = self
        school_txt.delegate = self

        school_txt.optionArray = []
        
        school_txt.isSearchEnable = true
        school_txt.didSelect{(selectedText , index ,id) in
            self.school_txt.isEnabled = true
            Logger.d("Selected String: \(selectedText) \n index: \(index) \n ID \(id)")
        }
        
        class_txt.optionArray = []
        
        class_txt.isSearchEnable = true
        class_txt.didSelect{(selectedText , index ,id) in
            self.class_txt.isEnabled = true
            Logger.d("Selected String: \(selectedText) \n index: \(index) \n ID \(id)")
        }
        
        city_txt.optionArray = []
        
        city_txt.isSearchEnable = true
        city_txt.didSelect{(selectedText , index ,id) in
            self.city_txt.isEnabled = true
            Logger.d("Selected String: \(selectedText) \n index: \(index) \n ID \(id)")
        }
    }
}

extension EnterSchoolDetailsViewController : UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        self.resetCountDownTime()

        let queryText = textField.text ?? "" + string
        switch textField {

        case self.city_txt:
//            break
                APIDataProvider.init().searchLocation(bodyParams: ["query" : queryText]) { response in

                    self.searchLocations = response
                    var searchLocations : [String] = []
                    response?.enumerated().forEach({ element in
                        searchLocations.append(element.element.city ?? "")

                        if ((response?.count ?? 0)-1) == element.offset{
                            self.city_txt.optionArray = searchLocations
                        }

                    })

                } onError: { error in

                    Logger.e(error?.debugDescription)

                }

        case self.school_txt:
            break

        case self.class_txt:
            break

        default:

            break
        }

        return true

    }

//    func resetCountDownTime(){
//        self.countDownTime = 3
//    }
//    func canCallApi(onTimeUp : @escaping()->()) {
//        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
//            if self.countDownTime > 0 {
//                print ("\(self.countDownTime) seconds")
//                self.countDownTime -= 1
//            } else {
//                Timer.invalidate()
//                onTimeUp()
//            }
//        }
//    }

    
    
}
