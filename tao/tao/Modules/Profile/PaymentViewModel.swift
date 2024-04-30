//
//  PaymentViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 17/07/22.
//

import Foundation

class PaymentViewModel: BaseViewModel {
    let planDetails: PlanDetails
    var inTransitOrder: InTransitOrder?
    var completition: ()-> Void
    
    init(planDetails: PlanDetails, completition: @escaping ()-> Void) {
        self.completition = completition
        self.planDetails = planDetails
        super.init()
    }
    
    func payWithTaoCashTapped() {
        self.apiProvider.manageSubscription.payWithTaoCash(planDetails: self.planDetails) { reponse, error in
            if error != nil {
                self.handleError(error: error)
            } else {
                APIDataProvider.init().getUserDetails { success in
                    if let userProfile = success {
                        TaoHelper.userProfile = userProfile
                    }
                    self.completition()
                } onError: { error in
                    self.viewHandler?.showToast(with: error?.debugDescription)
                    self.completition()
                }
            }
        }
    }
    
    func payWithRazorpayTapped(completion: @escaping ()-> Void) {
        self.viewHandler?.showLoading()
        self.apiProvider.manageSubscription.createPayment(planDetails: planDetails) { order, error in
            self.viewHandler?.stopLoading()
            if error != nil {
                self.handleError(error: error)
            } else {
                self.inTransitOrder = order
                completion()
            }
        }
    }
    
    func paymentCompletedWithRazorpay(paymentId: String) {
        if let inTransitOrder = inTransitOrder {
            self.viewHandler?.showLoading()
            self.apiProvider.manageSubscription.validatePayment(order: inTransitOrder,
                                                                paymentId: paymentId) { respone, error in
                self.viewHandler?.stopLoading()
                if error != nil {
                    self.handleError(error: error)
                } else {
                    APIDataProvider.init().getUserDetails { success in
                        if let userProfile = success {
                            TaoHelper.userProfile = userProfile
                        }
                        self.completition()
                    } onError: { error in
                        self.viewHandler?.showToast(with: error?.debugDescription)
                        self.completition()
                    }
                }
            }

        }
    }
    
    func paymentFailedWithRazorpay() {
        self.viewHandler?.showToast(with: "Payment Failed !! Please try again!")
    }
    
    func backButtonTapped() {
        self.viewHandler?.popViewController()
    }
}
