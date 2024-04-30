//
//  ManageSubscriptionViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 16/07/22.
//

import Foundation

class ManageSubscriptionViewModel: BaseViewModel {
    
    var planDetails: [PlanDetails]?
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.viewHandler?.showLoading()
        self.apiProvider.manageSubscription.getAllActivePlans { planDetails, error in
            self.viewHandler?.stopLoading()
            if error != nil {
                self.handleError(error: error)
            } else {
                self.planDetails = planDetails?.body
                self.viewHandler?.reloadView()
            }
        }
    }
    
    func backActionTapped() {
        self.viewHandler?.popViewController()
    }
    
    func itemTapped(index: Int) {
        if let planDetail = self.planDetails?[index] {
            self.viewHandler?.showPaymentScreen(planDetail: planDetail, completition: {
                DispatchQueue.main.async {
                    self.viewHandler?.popViewController()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.viewHandler?.showToast(with: "Payment Successful!!")
                }
            })
        }
    }
    
    func cancelSubscriptionTapped() {
        self.apiProvider.manageSubscription.cancelCurrentPlan { emptyResponse, error in
            if error != nil {
                self.handleError(error: error)
            } else {
                self.viewHandler?.showToast(with: "Subscription Cancelled")
                APIDataProvider.init().getUserDetails { success in
                    if let userProfile = success {
                        TaoHelper.userProfile = userProfile
                        self.viewHandler?.reloadView()
                    }
                } onError: { error in
                    self.viewHandler?.showToast(with: error?.debugDescription)
                }
            }
        }
    }
    
    func autoSubscibeTapped() {
        let subscribe = !(TaoHelper.userProfile?.userDetails?.autoSubscribe ?? false)
        self.apiProvider.profileApi.autoSubscribe(subscribe: subscribe) { _, error in
            if error != nil {
                self.handleError(error: error)
            } else {
                TaoHelper.userProfile?.userDetails?.autoSubscribe = subscribe
                TaoHelper.userProfile?.userSubscriptionDetails?.autoSubscribed = subscribe
                if subscribe {
                    self.viewHandler?.showToast(with: "Auto Subscribed!!")
                } else {
                    self.viewHandler?.showToast(with: "Disabled auto subscribed!!")
                }
                
            }
        }
    }
}
