//
//  NotificationApi.swift
//  tao
//
//  Created by Mayank Khursija on 11/08/22.
//

import Foundation
import Alamofire

protocol NotificationApi {
    func getNotifications(compeltion: @escaping (Notifications?, AFError?)->Void)
}

class NotificationApiImpl: Api, NotificationApi {
    let notificationsURL = "\(AppController.shared.getBaseURL())api/v2/internal/notification/%@"
    
    func getNotifications(compeltion: @escaping (Notifications?, AFError?)->Void) {
        
        let url = String(format: self.notificationsURL, TaoHelper.userID ?? "")
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: url,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    completion: compeltion)
    }
}
