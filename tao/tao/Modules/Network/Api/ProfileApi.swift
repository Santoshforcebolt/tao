//
//  ProfileApi.swift
//  tao
//
//  Created by Mayank Khursija on 26/06/22.
//

import Foundation
import Alamofire

protocol ProfileApi {
    func getKycStatus(completion: @escaping (KycStatus?,AFError?)-> Void)
    func uploadId(fileURL: URL, completion: @escaping (KycDocument?, AFError?)-> Void)
    func requestForKYC(idType: String,
                       uniqueId: String?,
                       idUrl: String,
                       completion: @escaping (KycStatus?, AFError?)-> Void)
    func getWalletBanners(completion: @escaping (WalletBanners?, AFError?)-> Void)
    func getWalletDetails(completion: @escaping (UserWalletResponse?, AFError?)-> Void)
    func deleteAddress(addressId: String, completion: @escaping (EmptyResponse?, AFError?)->Void)
    func updateAddress(address: Address, completion: @escaping (EmptyResponse?, AFError?)->Void)
    func getOrderList(completion: @escaping (OrderList?, AFError?)-> Void)
    func getTransactions(completion: @escaping (Transactions?, AFError?)-> Void)
    func createFundAccount(vpa: String, amount: Int, completion: @escaping (FundAccount?, AFError?)-> Void)
    func createPayout(vpa: String,
                      amount: Int,
                      accountId: String,
                      contactId: String,
                      completion: @escaping (Payout?, AFError?)-> Void)
    func getProfile(for userId: String, completion: @escaping (VisitProfile?, AFError?)-> Void)
    func getUserProfileEntries(id: String, completion: @escaping (ProfileMedia?, AFError?)-> Void)
    func followUser(id: String, completion: @escaping (EmptyResponse?, AFError?)-> Void)
    func unfollowUser(id: String, completion: @escaping (EmptyResponse?, AFError?)-> Void)
    func blockUser(id: String, completion: @escaping (EmptyResponse?, AFError?)-> Void)
    func unblockUser(id: String, completion: @escaping (EmptyResponse?, AFError?)-> Void)
    func createSchool(params: [String: Any], completition: @escaping (EmptyResponse?, AFError?)-> Void)
    func submitFeedback(text: String, completition: @escaping (EmptyResponse?, AFError?)-> Void)
    func getUserReferrals(cursor: String?, completition: @escaping (Referrals?, AFError?)-> Void)
    func getUserReferralsData(completition: @escaping (ReferralsData?, AFError?)-> Void)
    func autoSubscribe(subscribe: Bool, completition: @escaping (EmptyResponse?, AFError?)-> Void)
}

class ProfileApiImpl: Api, ProfileApi {
    let kycStatusUrl = "\(AppController.shared.getBaseURL())api/v2/kyc/%@"
    let uploadIdUrl = "\(AppController.shared.getBaseURL())api/v1/media/upload"
    let requestKYCUrl = "\(AppController.shared.getBaseURL())api/v1/kyc/create/%@"
    let walletBannersUrl = "\(AppController.shared.getBaseURL())api/v1/wallet/banners/%@"
    let walletDetailsUrl = "\(AppController.shared.getBaseURL())api/v1/wallet/%@"
    let deleteAddressUrl = "\(AppController.shared.getBaseURL())api/v1/address/delete/user/%@"
    let updateAddressUrl = "\(AppController.shared.getBaseURL())api/v1/address/update/%@"
    let getOrdersUrl = "\(AppController.shared.getBaseURL())api/v1/store/getOrderList"
    let getTransactionsUrl = "\(AppController.shared.getBaseURL())api/v2/transaction/%@"
    let createFundAccountURL = "\(AppController.shared.getBaseURL())api/v1/wallet/account"
    let createPayoutURL = "\(AppController.shared.getBaseURL())api/v1/wallet/payout"
    let visitProfileURL = "\(AppController.shared.getBaseURL())api/v1/social-profile/%@"
    let getUserEntryURL = "\(AppController.shared.getBaseURL())api/v1/participation/getAllUserEntries/%@"
    let followUserURL = "\(AppController.shared.getBaseURL())api/v1/social-profile/follow/%@"
    let unfollowUserURL = "\(AppController.shared.getBaseURL())api/v1/social-profile/unfollow/%@"
    let blockUserURL = "\(AppController.shared.getBaseURL())api/v1/block/user/%@"
    let unblockUserURL = "\(AppController.shared.getBaseURL())api/v1/block/un/user/%@"
    let createSchoolURL = "\(AppController.shared.getBaseURL())api/v1/school/user/create"
    let submitFeedback = "\(AppController.shared.getBaseURL())api/v1/feedback/create"
    let getUserReferralsURL = "\(AppController.shared.getBaseURL())api/v1/referral/list/%@"
    let getUserReferralsDataURL = "\(AppController.shared.getBaseURL())api/v1/referral/page/%@"
    let autoSubscribeURL = "\(AppController.shared.getBaseURL())api/v1/userprofile/autosubscribe/\(TaoHelper.userID ?? "")"
    
    func getKycStatus(completion: @escaping (KycStatus?,AFError?)-> Void) {
        let url = String(format: self.kycStatusUrl, TaoHelper.userID ?? "")
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: url,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completion)
    }
    
    func uploadId(fileURL: URL, completion: @escaping (KycDocument?, AFError?)-> Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.upload(urlString: self.uploadIdUrl,
                                   fileURL: fileURL,
                                   method: .post,
                                   parameters: ["type": "general",
                                                "subType": "video"],
                                   headers: headers,
                                   completion: completion)
    }
    
    func requestForKYC(idType: String,
                       uniqueId: String?,
                       idUrl: String,
                       completion: @escaping (KycStatus?, AFError?)-> Void) {
        let url = String(format: self.requestKYCUrl, TaoHelper.userID ?? "")
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        let params: [String: Any]
        if let uniqueId = uniqueId {
            params = ["idType": idType,
                      "idUrl": idUrl,
                      "uniqueId": uniqueId]
        } else {
            params = ["idType": idType,
                      "idUrl": idUrl]
        }
        
        self.networkManager.request(urlString: url,
                                    method: .post,
                                    parameters: params,
                                    headers: headers,
                                    encoding: JSONEncoding.default,
                                    completion: completion)
        
    }
    
    func getWalletBanners(completion: @escaping (WalletBanners?, AFError?)-> Void) {
        let url = String(format: self.walletBannersUrl, TaoHelper.userID ?? "")
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: url,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completion)
    }
    
    func getWalletDetails(completion: @escaping (UserWalletResponse?, AFError?)-> Void) {
        let url = String(format: self.walletDetailsUrl, TaoHelper.userID ?? "")
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: url,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completion)
    }
    
    func deleteAddress(addressId: String, completion: @escaping (EmptyResponse?, AFError?)->Void) {
        let url = String(format: self.deleteAddressUrl, addressId)
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: url,
                                    method: .delete,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completion)
        
    }
    
    func updateAddress(address: Address, completion: @escaping (EmptyResponse?, AFError?)->Void) {
        let url = String(format: self.updateAddressUrl, address.id ?? "")
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: url,
                                    method: .post,
                                    parameters: ["country": address.country ?? "",
                                                 "district": address.district ?? "",
                                                 "house": address.house ?? "",
                                                 "phone": address.phone ?? "",
                                                 "pin": address.pin ?? "",
                                                 "state": address.state ?? "",
                                                 "street": address.street ?? "",
                                                 "userId": TaoHelper.userID ?? ""],
                                    headers: headers,
                                    encoding: JSONEncoding.default,
                                    completion: completion)
        
    }
    
    func getOrderList(completion: @escaping (OrderList?, AFError?)-> Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: self.getOrdersUrl,
                                    method: .post,
                                    parameters: ["userId": TaoHelper.userID ?? ""],
                                    headers: headers,
                                    encoding: JSONEncoding.default,
                                    completion: completion)
    }
    
    func getTransactions(completion: @escaping (Transactions?, AFError?)-> Void) {
        let url = String(format: self.getTransactionsUrl, "\(TaoHelper.userProfile?.walletResponse?.walletId ?? 0)")
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: url,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completion)
    }
    
    func createFundAccount(vpa: String, amount: Int, completion: @escaping (FundAccount?, AFError?)-> Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: self.createFundAccountURL,
                                    method: .post,
                                    parameters: ["vpa":vpa,
                                                 "amount": amount,
                                                 "userId": TaoHelper.userID ?? ""],
                                    headers: headers,
                                    encoding: JSONEncoding.default,
                                    completion: completion)
    }
    
    func createPayout(vpa: String,
                      amount: Int,
                      accountId: String,
                      contactId: String,
                      completion: @escaping (Payout?, AFError?)-> Void) {
        
        let headers = self.buildHeaders(additionalHeaders: nil)
        self.networkManager.request(urlString: self.createPayoutURL,
                                    method: .post,
                                    parameters: ["vpa":vpa,
                                                 "amount": amount,
                                                 "accountId": accountId,
                                                 "contactId": contactId,
                                                 "userId": TaoHelper.userID ?? ""],
                                    headers: headers,
                                    encoding: JSONEncoding.default,
                                    completion: completion)
    }
    
    func getProfile(for userId: String, completion: @escaping (VisitProfile?, AFError?)-> Void) {
        let url = String(format: self.visitProfileURL, userId)
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: url,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completion)
        
    }
    
    func getUserProfileEntries(id: String, completion: @escaping (ProfileMedia?, AFError?)-> Void) {
        let url = String(format: self.getUserEntryURL, id)
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: url,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completion)
    }
    
    func followUser(id: String, completion: @escaping (EmptyResponse?, AFError?)-> Void) {
        let url = String(format: self.followUserURL, id)
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: url,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completion)
    }
    
    func unfollowUser(id: String, completion: @escaping (EmptyResponse?, AFError?)-> Void) {
        let url = String(format: self.unfollowUserURL, id)
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: url,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completion)
    }
    
    func blockUser(id: String, completion: @escaping (EmptyResponse?, AFError?)-> Void) {
        let url = String(format: self.blockUserURL, id)
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: url,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completion)
    }
    
    func unblockUser(id: String, completion: @escaping (EmptyResponse?, AFError?)-> Void) {
        let url = String(format: self.unblockUserURL, id)
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: url,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completion)
    }
    
    func createSchool(params: [String: Any], completition: @escaping (EmptyResponse?, AFError?)-> Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        self.networkManager.request(urlString: self.createSchoolURL,
                                    method: .post,
                                    parameters: params,
                                    headers: headers,
                                    encoding: JSONEncoding.default,
                                    completion: completition)
    }
    
    func submitFeedback(text: String, completition: @escaping (EmptyResponse?, AFError?)-> Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        let params = ["feedback": text, "userId": TaoHelper.userID ?? ""]
        
        self.networkManager.request(urlString: self.submitFeedback,
                                    method: .post,
                                    parameters: params,
                                    headers: headers,
                                    encoding: JSONEncoding.default,
                                    completion: completition)
    }
    
    func getUserReferrals(cursor: String?, completition: @escaping (Referrals?, AFError?)-> Void) {
        let url = String(format: self.getUserReferralsURL, TaoHelper.userID ?? "")
        let headers = self.buildHeaders(additionalHeaders: nil)
        let params: [String:Any]
        if let cursor = cursor {
            params = ["cursor": cursor]
        } else {
            params = [:]
        }
        self.networkManager.request(urlString: url,
                                    method: .get,
                                    parameters: params,
                                    headers: headers,
                                    completion: completition)
    }
    
    func getUserReferralsData(completition: @escaping (ReferralsData?, AFError?)-> Void) {
        let url = String(format: self.getUserReferralsDataURL, TaoHelper.userID ?? "")
        let headers = self.buildHeaders(additionalHeaders: nil)

        self.networkManager.request(urlString: url,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completition)
    }
    
    func autoSubscribe(subscribe: Bool, completition: @escaping (EmptyResponse?, AFError?)-> Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: self.autoSubscribeURL,
                                    method: .post,
                                    parameters: ["autoSubscribe": subscribe,
                                                 "id": TaoHelper.userID ?? ""],
                                    headers: headers,
                                    encoding: JSONEncoding.default,
                                    completion: completition)
    }
}
