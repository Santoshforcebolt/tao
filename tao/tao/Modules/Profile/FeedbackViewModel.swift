//
//  FeedbackViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 12/08/22.
//

import Foundation

class FeedbackViewModel: BaseViewModel {
    
    func backButtonTapped() {
        self.viewHandler?.popViewController()
    }
    
    func submitButtonTapped(text: String) {
        self.viewHandler?.showLoading()
        self.apiProvider.profileApi.submitFeedback(text: text) { _, error in
            self.viewHandler?.stopLoading()
            if error != nil {
                self.handleError(error: error)
            } else {
                self.viewHandler?.showToast(with: "Feedback submitted!")
            }
        }
    }
}
