//
//  ManageSubscriptionApi.swift
//  tao
//
//  Created by Mayank Khursija on 17/07/22.
//

import Foundation
import Alamofire

protocol ManageSubscriptionApi {
    func getAllActivePlans(completion: @escaping (SubscriptionPlans?, AFError?)->Void)
    func payWithTaoCash(planDetails: PlanDetails, completion: @escaping (EmptyResponse?, AFError?)-> Void)
    func cancelCurrentPlan(completion: @escaping (EmptyResponse?, AFError?)-> Void)
    func createPayment(planDetails: PlanDetails, completion: @escaping (InTransitOrder?, AFError?)-> Void)
    func validatePayment(order: InTransitOrder, paymentId: String, completion: @escaping (EmptyResponse?, AFError?)-> Void)
}

class ManageSubscriptionApiImpl: Api, ManageSubscriptionApi {
    let getActivePlansURL = "\(AppController.shared.getBaseURL())api/v1/subscription/getActivePlans/%@"
    let subscibeViaTaoCashURL = "\(AppController.shared.getBaseURL())api/v1/subscription/subscribe/tao-cash"
    let cancelPlanURL = "\(AppController.shared.getBaseURL())api/v1/subscription/expire/%@"
    let createPaymentURL = "\(AppController.shared.getBaseURL())api/v1/wallet/payment/create"
    let validatePaymentURL = "\(AppController.shared.getBaseURL())api/v1/wallet/payment/validate/%@"
    
    func getAllActivePlans(completion: @escaping (SubscriptionPlans?, AFError?)->Void) {
        let planURL = String(format: self.getActivePlansURL, TaoHelper.userID ?? "")
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: planURL,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completion)
    }
    
    func payWithTaoCash(planDetails: PlanDetails, completion: @escaping (EmptyResponse?, AFError?)-> Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        let parameters = ["premiumPlanId": planDetails.id ?? "",
                          "amountPaid": planDetails.discountedPrice ?? 0,
                          "userId" : TaoHelper.userID ?? ""] as [String : Any]
        
        self.networkManager.request(urlString: self.subscibeViaTaoCashURL,
                                    method: .post,
                                    parameters: parameters,
                                    headers: headers,
                                    encoding: JSONEncoding.default,
                                    completion: completion)
        
    }
    
    func cancelCurrentPlan(completion: @escaping (EmptyResponse?, AFError?)-> Void) {
        let cancelURL = String(format: self.cancelPlanURL, TaoHelper.userID ?? "")
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: cancelURL,
                                    method: .post,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completion)
        
    }
    
    func createPayment(planDetails: PlanDetails, completion: @escaping (InTransitOrder?, AFError?)-> Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        let parameters = ["amount": planDetails.discountedPrice ?? 0,
                          "userId": TaoHelper.userID ?? "",
                          "productId": planDetails.id ?? "",
                          "productName": planDetails.name ?? "",
                          "productCategory" : "SUBSCIPTION"] as [String : Any]
        
        self.networkManager.request(urlString: self.createPaymentURL,
                                    method: .post,
                                    parameters: parameters,
                                    headers: headers,
                                    encoding: JSONEncoding.default,
                                    completion: completion)
    }
    
    func validatePayment(order: InTransitOrder, paymentId: String, completion: @escaping (EmptyResponse?, AFError?)-> Void) {
        let validateURL = String(format: self.validatePaymentURL, TaoHelper.userID ?? "")
        let headers = self.buildHeaders(additionalHeaders: nil)
        let params = ["orderId": order.orderId ?? "",
                      "partnerOrderId": order.partnerOrderId ?? "",
                      "status": order.orderStatus ?? "",
                      "timestamp": DateManager.shared.getTodayDateString(outputFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"),
                      "paymentId": paymentId]
        self.networkManager.request(urlString: validateURL,
                                    method: .post,
                                    parameters: params,
                                    headers: headers,
                                    encoding: JSONEncoding.default,
                                    completion: completion)
    }
}
