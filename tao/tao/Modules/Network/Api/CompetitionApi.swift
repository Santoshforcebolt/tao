//
//  CompetitionApi.swift
//  tao
//
//  Created by Mayank Khursija on 08/08/22.
//

import Foundation
import Alamofire

protocol CompetitionApi {
    func getCompetitions(with code: String,
                         completion: @escaping ([CompetitionData]?, AFError?)-> Void)
    func getMyCompetitions(cateogry: String, cursor: String?, completition: @escaping (MyCompetitions?, AFError?)-> Void)
    func getCompetition(by id: String, completion: @escaping (AcademicCompetitions?, AFError?)-> Void)
    func getEntries(competitionId: String, cursor: String?, completition: @escaping (CompetitionEntries?, AFError?)-> Void)
    func getUserEntries(cursor: String?, completition: @escaping (CompetitionEntries?, AFError?)-> Void)
    func getCertificateDetails(competitionId: String, completition: @escaping (CertificateData?, AFError?)-> Void)
    func downloadImage(url: String, completion: @escaping (Data?, AFError?)->Void)
}

class CompetitionApiImpl: Api, CompetitionApi {
    let getPrivateCompetitionsURL = "\(AppController.shared.getBaseURL())api/v1/competition/private/multi/%@"
    let getCompetitionsURL = "\(AppController.shared.getBaseURL())api/v1/participation/getUserCompetitions/%@"
    let getCompetitionByIdURL = "\(AppController.shared.getBaseURL())api/v1/competition/%@"
    let getCompetitionEntriesURL = "\(AppController.shared.getBaseURL())api/v1/participation/getCompEntries/%@"
    let getUserEntriesURL = "\(AppController.shared.getBaseURL())api/v1/participation/getAllUserEntries/%@"
    let downloadCertificateURL = "\(AppController.shared.getBaseURL())api/v1/certificate/%@/user/%@"
    
    func getCompetitions(with code: String,
                         completion: @escaping ([CompetitionData]?, AFError?)-> Void) {
        let url = String(format: self.getPrivateCompetitionsURL, code)
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: url,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completion)
    }
    
    func getMyCompetitions(cateogry: String, cursor: String?, completition: @escaping (MyCompetitions?, AFError?)-> Void) {
        let url = String(format: self.getCompetitionsURL, TaoHelper.userID ?? "")
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        if let cursor = cursor {
            self.networkManager.request(urlString: url,
                                        method: .get,
                                        parameters: ["category": cateogry, "cursor": cursor],
                                        headers: headers,
                                        completion: completition)
        } else {
            self.networkManager.request(urlString: url,
                                        method: .get,
                                        parameters: ["category": cateogry],
                                        headers: headers,
                                        completion: completition)
        }
    }
    
    func getCompetition(by id: String, completion: @escaping (AcademicCompetitions?, AFError?)-> Void) {
        let url = String(format: self.getCompetitionByIdURL, id)
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: url,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completion)
    }
    
    func getEntries(competitionId: String, cursor: String?, completition: @escaping (CompetitionEntries?, AFError?)-> Void) {
        let url = String(format: self.getCompetitionEntriesURL, competitionId)
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        let params: [String: Any]
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
    
    func getUserEntries(cursor: String?, completition: @escaping (CompetitionEntries?, AFError?)-> Void) {
        let url = String(format: self.getUserEntriesURL, TaoHelper.userID ?? "")
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        let params: [String: Any]
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
    
    func getCertificateDetails(competitionId: String, completition: @escaping (CertificateData?, AFError?)-> Void) {
        let url = String(format: self.downloadCertificateURL, competitionId, TaoHelper.userID ?? "")
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: url,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completition)
    }
    
    func downloadImage(url: String, completion: @escaping (Data?, AFError?)->Void) {
        self.networkManager.download(url: url, completion: completion)
    }
}
