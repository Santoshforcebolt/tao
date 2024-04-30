//
//  UserBlockedViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 13/07/22.
//

import Foundation

class UserBlockedViewModel: BaseViewModel {
    private var userId: String
    var completion: (Bool)-> Void
    
    init(userId: String, completion: @escaping (Bool)-> Void) {
        self.completion = completion
        self.userId = userId
        super.init()
    }
    
    func unBlockTapped() {
        self.viewHandler?.showLoading()
        self.apiProvider.profileApi.unblockUser(id: self.userId) { _, error in
            if error != nil {
                self.handleError(error: error)
            } else {
                self.completion(true)
            }
        }
    }
    
    func backButtonTapped() {
        self.viewHandler?.popViewController()
    }
}
