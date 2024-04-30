//
//  AlamoNetworkManager.swift
//  tao
//
//  Created by Mayank Khursija on 28/05/22.
//

import Foundation
import Alamofire

//FIXME: Error Handling Not working proplery, Initally Observed in status 400 calls. AFError is nil but server is throwing 400.
class AlamoNetworkManager {
    func request<T: Codable>(urlString: String,
                             method: Alamofire.HTTPMethod,
                             parameters: [String: Any],
                             headers: Alamofire.HTTPHeaders,
                             encoding: Alamofire.ParameterEncoding = URLEncoding.default,
                             completion: @escaping (T?, AFError?) -> Void) {
        AF.request(urlString,
                   method: method,
                   parameters: parameters,
                   encoding: encoding,
                   headers: headers).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let result):
                completion(result, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }.validate(statusCode: 200..<299)
    }
    
    func upload<T: Codable>(urlString: String,
                            fileURL: URL,
                            method: Alamofire.HTTPMethod,
                            parameters: [String: Any],
                            headers: Alamofire.HTTPHeaders,
                            completion: @escaping (T?, AFError?) -> Void) {
        
        AF.upload(
            multipartFormData: { multiPartData in
                do {
                    let data = try Data(contentsOf: fileURL, options: .mappedIfSafe)
                    
                    for (key, value) in parameters {
                        multiPartData.append((value as! String).data(using: .utf8)!,
                                             withName: key)
                    }
                    
                    multiPartData.append(data,
                                         withName: "file",
                                         fileName: "file.mp4",
                                         mimeType: "video/mp4")
                    
                } catch {
                    print(error)
                }
            },
            to: urlString,
            method: method,
            headers: headers)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let result):
                    completion(result, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }
    
    func download(url: String, completion: @escaping (Data?, AFError?) -> Void) {
        AF.request(url, method: .get).response { response in
            switch response.result {
            case .success(let responseData):
                completion(responseData, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
}
