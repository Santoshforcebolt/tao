//
//  LeaderBoardApi.swift
//  tao
//
//  Created by Mayank Khursija on 01/07/22.
//

import Foundation
import Alamofire

protocol LeaderBoardApi {
    func getSubCategories(for type: String, completion: @escaping ([String]?, AFError?)-> Void)
    func getLeaderBoardData(type: String,
                            month: Int,
                            year: Int,
                            subcategory: String,
                            completion: @escaping (LeaderBoardData?, AFError?)->Void)
}

class LeaderBoardApiImpl: Api, LeaderBoardApi {
    let getSubCategoriesURL = "\(AppController.shared.getBaseURL())api/v1/subcategory/leaderboard/%@"
    let getLeaderBoard = "\(AppController.shared.getBaseURL())api/v2/leaderboard/%@"
    let getLeaderBoardCompetitionURL = "\(AppController.shared.getBaseURL())api/v2/leaderboard/competition/%@"
    
    func getSubCategories(for type: String, completion: @escaping ([String]?, AFError?)-> Void) {
        
        let url = String(format: self.getSubCategoriesURL, type)
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: url,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completion)
    }
    
    func getLeaderBoardData(type: String,
                            month: Int,
                            year: Int,
                            subcategory: String,
                            completion: @escaping (LeaderBoardData?, AFError?)->Void) {
        
        let url = String(format: self.getLeaderBoard, type)
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: url,
                                    method: .post,
                                    parameters: ["month": month,
                                                 "subCategory": subcategory,
                                                 "year": year],
                                    headers: headers,
                                    encoding: JSONEncoding.default,
                                    completion: completion)
        
    }
}
