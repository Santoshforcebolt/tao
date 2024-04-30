//
//  TVApi.swift
//  tao
//
//  Created by Mayank Khursija on 13/06/22.
//

import Foundation
import Alamofire

protocol TVApi {
    func like(parameters: [String: Any],
              completion: @escaping (EmptyResponse?, AFError?)-> Void)
    func getAllMedia(parameters: [String: Any],
                     completion: @escaping (TVItem?, AFError?) -> Void)
    func trackView(parameters: [String: Any],
                   completion: @escaping (EmptyResponse?, AFError?)-> Void)
    func getSearchResults(query: String,
                          completion: @escaping (UserSearchInfo?, AFError?) -> Void)
    func getReportReasons(completion: @escaping ([ReportReason]?, AFError?) -> Void)
    func reportMedia(
        userId: String,
        mediaId: String,
        reportReason: ReportReason,
        completion: @escaping (EmptyResponse?, AFError?) -> Void)
    func reportUser(userId: String, completion: @escaping (EmptyResponse?, AFError?) -> Void)
}

class TVApiImpl: Api, TVApi {
    let likeUrl = "\(AppController.shared.getBaseURL())api/v1/explore/registerActivity/%@"
    let getAllMediaUrl = "\(AppController.shared.getBaseURL())api/v1/explore/get"
    let trackViewUrl = "\(AppController.shared.getBaseURL())api/v1/explore/updateStats/%@"
    let searchUrl = "\(AppController.shared.getBaseURL())api/v1/search/user"
    let reportMediaReasonsUrl = "\(AppController.shared.getBaseURL())api/v1/report/reason/MEDIA"
    let reportMediaUrl = "\(AppController.shared.getBaseURL())api/v1/report/media"
    let blockUserUrl = "\(AppController.shared.getBaseURL())/api/v1/block/user/%@"
    
    //params = activity, userId
    func like(parameters: [String: Any],
              completion: @escaping (EmptyResponse?, AFError?)-> Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        if let mediaId = parameters["mediaId"] as? String,
           mediaId.isEmpty == false {
            let url = String(format: self.likeUrl, mediaId)
            var mutableParams = parameters
            mutableParams.removeValue(forKey: "mediaId")
            self.networkManager.request(urlString: url,
                                        method: .post,
                                        parameters: mutableParams,
                                        headers: headers,
                                        encoding: URLEncoding.default,
                                        completion: completion)

        }
    }
    
    func getAllMedia(parameters: [String: Any],
                     completion: @escaping (TVItem?, AFError?) -> Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        self.networkManager.request(urlString: self.getAllMediaUrl,
                                    method: .get,
                                    parameters: parameters,
                                    headers: headers,
                                    completion: completion)
    }
    
    func trackView(parameters: [String: Any],
                   completion: @escaping (EmptyResponse?, AFError?)-> Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        if let mediaId = parameters["mediaId"] as? String,
           mediaId.isEmpty == false {
            let url = String(format: self.trackViewUrl, mediaId)
            var mutableParams = parameters
            mutableParams.removeValue(forKey: "mediaId")
            self.networkManager.request(urlString: url,
                                        method: .post,
                                        parameters: mutableParams,
                                        headers: headers,
                                        encoding: JSONEncoding.default,
                                        completion: completion)

        }
    }
    
    func getSearchResults(query: String, completion: @escaping (UserSearchInfo?, AFError?) -> Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: self.searchUrl,
                                    method: .post,
                                    parameters: ["query": query],
                                    headers: headers,
                                    encoding: JSONEncoding.default,
                                    completion: completion)
    }
    
    func getReportReasons(completion: @escaping ([ReportReason]?, AFError?) -> Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: self.reportMediaReasonsUrl,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completion)
    }
    
    func reportMedia(userId: String, mediaId: String, reportReason: ReportReason, completion: @escaping (EmptyResponse?, AFError?) -> Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        let params: [String: String] = ["mediaId": mediaId,
                                        "reason": reportReason.description ?? "",
                                        "reasonId": reportReason.id ?? "",
                                        "reportedBy": TaoHelper.userID ?? "",
                                        "userId": userId]
        self.networkManager.request(urlString: self.reportMediaUrl,
                                    method: .post,
                                    parameters: params,
                                    headers: headers,
                                    encoding: JSONEncoding.default,
                                    completion: completion)
    }
    
    func reportUser(userId: String, completion: @escaping (EmptyResponse?, AFError?) -> Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        let urlString = String(format: self.blockUserUrl, userId)
        self.networkManager.request(urlString: urlString,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completion)
        
    }
}
