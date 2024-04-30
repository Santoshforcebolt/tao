//
//  AppController.swift
//  tao
//
//  Created by Betto Akkara on 03/02/22.
//

import Foundation

enum appEnvironment {
    case DEBUG
    case PRODUCTION
}

enum UserStatus {
    case onBoarded
    case not_onBoarded
    case registered
    case user
}

class AppController {

    static var shared : AppController{
        let sharedObj = AppController()
        return sharedObj
    }

    class func manager() -> AppController{
        return shared
    }


    public static var isTxnTabNeedsToLayout = true
    var networkEnvironment : NetworkEnvironment = .staging
    var app_environment : appEnvironment = .DEBUG

    var mobileNumber : String = TaoUserDefaults.standard.object(forKey: TaoUserDefaultKeys.mobile.rawValue) as? String ?? ""
    var deviceID : String = TaoUserDefaults.standard.object(forKey: TaoUserDefaultKeys.deviceID.rawValue) as? String ?? ""

    var isUserSignedin : Bool {
        if let jwtToken = (TaoUserDefaults.standard.object(forKey: TaoUserDefaultKeys.jwtToken.rawValue) as? String),
           jwtToken.isEmpty == false,
           let jwtTokenRef = (TaoUserDefaults.standard.object(forKey: TaoUserDefaultKeys.jwtTokenRef.rawValue) as? String),
           jwtTokenRef.isEmpty == false,
           let mobile = (TaoUserDefaults.standard.object(forKey: TaoUserDefaultKeys.mobile.rawValue) as? String),
           mobile.isEmpty == false,
           //FIXME: Pending implementation for device Id
//           let deviceId = (TaoUserDefaults.standard.object(forKey: TaoUserDefaultKeys.deviceID.rawValue) as? String),
//           deviceId.isEmpty == false,
           let userId = (TaoUserDefaults.standard.object(forKey: TaoUserDefaultKeys.userId.rawValue) as? String),
           userId.isEmpty == false
        {
            return true
        }
        return false
    }

    func getBaseURL() -> String {
        switch networkEnvironment {
        case .production:
            return "https://core.tao.live/tao/"
        case .staging:
            return "https://app.taodev.live/tao/"
        case .uat:
            return "https://app.taodev.live/tao/"
        }
    }

    func clearUserState() {
        TaoUserDefaults.standard.removeObject(forKey: TaoUserDefaultKeys.jwtToken.rawValue)
        TaoUserDefaults.standard.removeObject(forKey: TaoUserDefaultKeys.jwtTokenRef.rawValue)
        TaoUserDefaults.standard.removeObject(forKey: TaoUserDefaultKeys.userId.rawValue)
        TaoUserDefaults.standard.removeObject(forKey: TaoUserDefaultKeys.mobile.rawValue)
        TaoUserDefaults.standard.removeObject(forKey: TaoUserDefaultKeys.deviceID.rawValue)
    }
    
    func saveUserState(phone: String,
                       token: String,
                       refreshToken: String,
                       userId: String) {
        TaoUserDefaults.standard.set(phone, forKey: TaoUserDefaultKeys.mobile.rawValue)
        TaoUserDefaults.standard.set(token, forKey: TaoUserDefaultKeys.jwtToken.rawValue)
        TaoUserDefaults.standard.set(refreshToken, forKey: TaoUserDefaultKeys.jwtTokenRef.rawValue)
        TaoUserDefaults.standard.set(userId, forKey: TaoUserDefaultKeys.userId.rawValue)
    }
}

enum TaoUserDefaultKeys : String{
    case jwtToken = "jwtToken"
    case jwtTokenRef = "jwtTokenRef"
    case mobile = "mobile"
    case deviceID = "deviceID"
    case userId = "userId"
}
