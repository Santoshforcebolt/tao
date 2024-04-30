//
//  HomeApi.swift
//  tao
//
//  Created by Mayank Khursija on 22/08/22.
//

import Foundation
import Alamofire

protocol HomeApi {
    func getHomeDetails(completition: @escaping (HomeDetails?, AFError?)-> Void)
    func getUserProfile(completition: @escaping (UserProfile?, AFError?)-> Void)
    func getCompetitionCategories(completition: @escaping (CompetitionCategories?, AFError?)-> Void)
    func getAppConfig(completition: @escaping (GetAppConfig?, AFError?)-> Void)
    func getWidgets(completition: @escaping (Banners?, AFError?)-> Void)
    func getCompetitionsByCategories(category: String,
                                     subcategory: String,
                                     completition: @escaping (CateogryCompetitions?, AFError?)-> Void)
    func getGames(completition: @escaping (Games?, AFError?)->Void)
}

class HomeApiImpl: Api, HomeApi {
    
    let getHomePageDetailsURL = "\(AppController.shared.getBaseURL())api/v2/homepage/get"
    let getUserProfileURL = "\(AppController.shared.getBaseURL())api/v1/userprofile/\(TaoHelper.userID ?? "")"
    let getAppConfigURL = "\(AppController.shared.getBaseURL())api/v1/config/app"
    let getCompetitionCategoriesURL = "\(AppController.shared.getBaseURL())api/v1/category-data/getAll"
    let getWidgetsURL = "\(AppController.shared.getBaseURL())api/v1/widgets/user/get"
    let getCompetitionsByCategoriesURL = "\(AppController.shared.getBaseURL())api/v1/competition/category/%@/sub/%@"
    let getGamesURL = "\(AppController.shared.getBaseURL())api/v1/games/\(TaoHelper.userID ?? "")"
    
    func getHomeDetails(completition: @escaping (HomeDetails?, AFError?)-> Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: self.getHomePageDetailsURL,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completition)
    }
    
    func getUserProfile(completition: @escaping (UserProfile?, AFError?)-> Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: self.getUserProfileURL,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completition)
    }
    
    func getCompetitionCategories(completition: @escaping (CompetitionCategories?, AFError?)-> Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: self.getCompetitionCategoriesURL,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completition)
    }
    
    func getAppConfig(completition: @escaping (GetAppConfig?, AFError?)-> Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: self.getAppConfigURL,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completition)
    }
    
    func getWidgets(completition: @escaping (Banners?, AFError?)-> Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: self.getWidgetsURL,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completition)
    }
    
    func getCompetitionsByCategories(category: String,
                                     subcategory: String,
                                     completition: @escaping (CateogryCompetitions?, AFError?)-> Void) {
        let url = String(format: self.getCompetitionsByCategoriesURL, category, subcategory)
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: url,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completition)
    }
    
    func getGames(completition: @escaping (Games?, AFError?)->Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: self.getGamesURL,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completition)
    }
}
