//
//  MediaApi.swift
//  tao
//
//  Created by Mayank Khursija on 28/05/22.
//

import Foundation
import Alamofire

protocol MediaApi {
    func uploadVideo(url: String,
                     videoUrl: URL,
                     parameters: [String: Any],
                     additionalHeaders: [String: String]?,
                     completion: @escaping (BunnyUploadDetails?, AFError?)-> Void)
    func getMediaDetails(userId: String,
                         competitionId: String,
                         parameters: [String: String]?,
                         additionalHeaders: [String: String]?,
                         completion: @escaping (MediaDetails?, AFError?)-> Void)
    func submitEntry(text: String, mediaType: String, media: MediaDetails, completition: @escaping (EmptyResponse?, AFError?)-> Void)
}

class MediaApiImpl: Api, MediaApi {
    let GET_MEDIA_URL = "\(AppController.shared.getBaseURL())api/v1/media/getMediaApp/%@/user/%@"
    let submitEntryURL = "\(AppController.shared.getBaseURL())api/v1/participation/submitEntry"
    
    func uploadVideo(url: String,
                     videoUrl: URL,
                     parameters: [String: Any],
                     additionalHeaders: [String: String]?,
                     completion: @escaping (BunnyUploadDetails?, AFError?) -> Void) {
        let headers = self.buildHeaders(additionalHeaders: additionalHeaders)
        self.networkManager.request(urlString: url,
                                    method: .put,
                                    parameters: parameters,
                                    headers: headers,
                                    completion: completion)
    }
    
    func getMediaDetails(userId: String,
                         competitionId: String,
                         parameters: [String: String]?,
                         additionalHeaders: [String: String]?,
                         completion: @escaping (MediaDetails?, AFError?) -> Void) {
        let headers = self.buildHeaders(additionalHeaders: additionalHeaders)
        let urlString = String(format: self.GET_MEDIA_URL, competitionId, userId)
        
        self.networkManager.request(urlString: urlString,
                                    method: .get,
                                    parameters: parameters ?? [:],
                                    headers: headers,
                                    completion: completion)
    }
    
    func submitEntry(text: String, mediaType: String, media: MediaDetails, completition: @escaping (EmptyResponse?, AFError?)-> Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        let mediaMetaData = ["competitionId": media.competitionId ?? "",
                             "resourceURL": media.url ?? "",
                             "thumbnailURL": media.thumbnailUrl ?? "",
                             "userId" : media.userId ?? "",
                             "name": text,
                             "mediaType": mediaType]
        
        let params = ["mediaMetaData": mediaMetaData,
                      "competitionId": media.competitionId ?? "",
                      "userId": media.userId ?? "",
                      "submittedTimestamp": DateManager.shared.getTodayDateString(outputFormat: "yyyy-MM-dd'T'HH:mm:ss")] as [String : Any]
        
        self.networkManager.request(urlString: self.submitEntryURL,
                                    method: .post,
                                    parameters: params,
                                    headers: headers,
                                    encoding: JSONEncoding.default,
                                    completion: completition)
        
    }
}
