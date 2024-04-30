//
//  Api.swift
//  tao
//
//  Created by Mayank Khursija on 28/05/22.
//

import Foundation
import Alamofire

class Api {
    var networkManager: AlamoNetworkManager
    
    init(networkManager: AlamoNetworkManager = AlamoNetworkManager()) {
        self.networkManager = networkManager
    }
    
    func buildHeaders(additionalHeaders: [String: String]?) -> Alamofire.HTTPHeaders {
        var headers: HTTPHeaders = [:]
        headers["cache-control"] = "no-cache"
        headers["Accept-Encoding"] = "gzip"
        if let token = (TaoUserDefaults.standard.object(forKey: TaoUserDefaultKeys.jwtToken.rawValue) as? String), token != ""{
            headers["Authorization"] = "Bearer \(token)"
        }

        if let userId = (TaoUserDefaults.standard.object(forKey: TaoUserDefaultKeys.userId.rawValue) as? String), userId != ""{
            headers["userid"] = "\(userId)"
        }
        headers["version_code"] = "25"
        headers["client_type"] = "ios"

        var alamoFireHeaders = Alamofire.HTTPHeaders(headers)

        if let additionalHeaders = additionalHeaders {
            for header in additionalHeaders {
                alamoFireHeaders.add(name: header.key, value: header.value)
            }
        }

        return alamoFireHeaders
    }
    
}
