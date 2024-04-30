//
//  QuizApi.swift
//  tao
//
//  Created by Mayank Khursija on 10/08/22.
//

import Foundation
import Alamofire

protocol QuizApi {
    func getQuestions(competitionId: String, userID: String, completion: @escaping (QuizQuestions?, AFError?)-> Void)
    func submitAnswer(params: [String: Any],
                      completion: @escaping (EmptyResponse?, AFError?)-> Void)
    func submitEntry(params: [String: Any],
                      completion: @escaping (EmptyResponse?, AFError?)-> Void)
    func evaluteQuiz(competitionId: String, completion: @escaping (Evaluation?, AFError?)->Void) 
}

class QuizApiImpl: Api, QuizApi {
    
    let questionsURL = "\(AppController.shared.getBaseURL())api/v1/participation/getQuestions"
    let submitAnswerURL = "\(AppController.shared.getBaseURL())api/v1/participation/submitAnswer"
    let submitEntryURL = "\(AppController.shared.getBaseURL())api/v1/participation/submitEntry"
    let evaluateQuizURL = "\(AppController.shared.getBaseURL())api/v1/participation/evalAcademicEntry"

    
    func getQuestions(competitionId: String, userID: String, completion: @escaping (QuizQuestions?, AFError?)-> Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        self.networkManager.request(urlString: self.questionsURL,
                                    method: .get,
                                    parameters: ["competitionId": competitionId,
                                                 "userId": userID],
                                    headers: headers,
                                    completion: completion)
    }
    
    func submitAnswer(params: [String: Any],
                      completion: @escaping (EmptyResponse?, AFError?)-> Void) {
        
        let headers = self.buildHeaders(additionalHeaders: nil)
        self.networkManager.request(urlString: self.submitAnswerURL,
                                    method: .post,
                                    parameters: params,
                                    headers: headers,
                                    encoding: JSONEncoding.default,
                                    completion: completion)
    }
    
    func submitEntry(params: [String: Any],
                      completion: @escaping (EmptyResponse?, AFError?)-> Void) {
        
        let headers = self.buildHeaders(additionalHeaders: nil)
        self.networkManager.request(urlString: self.submitEntryURL,
                                    method: .post,
                                    parameters: params,
                                    headers: headers,
                                    encoding: JSONEncoding.default,
                                    completion: completion)
    }
    
    func evaluteQuiz(competitionId: String, completion: @escaping (Evaluation?, AFError?)->Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: self.evaluateQuizURL,
                                    method: .get,
                                    parameters: ["competitionId": competitionId,
                                                 "userId": TaoHelper.userID ?? ""],
                                    headers: headers,
                                    completion: completion)
    }
}
