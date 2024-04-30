//
//  NotificationViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 11/08/22.
//

import Foundation

class NotificationViewModel: BaseViewModel {
    
    var notifications: Notifications?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewHandler?.showLoading()
        self.apiProvider.notificationApi.getNotifications { notifications, error in
            self.viewHandler?.stopLoading()
            if error != nil {
                self.viewHandler?.showToast(with: error.debugDescription)
            } else {
                self.notifications = notifications
                self.viewHandler?.reloadView()
            }
        }
    }
    
    func backButtonTapped() {
        self.viewHandler?.popViewController()
    }
}
