//
//  Networkmanager.swift
//  creditcardapp
//
//  Created by Betto Akkara on 22/09/21.
//

import Foundation

public enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

public enum Result<String>{
    case success
    case failure(String)
}

public enum NetworkEnvironment {
    case production
    case staging
    case uat
}

public func coreHeaders() -> HTTPHeaders {
    var header: HTTPHeaders = [:]
    header["cache-control"] = "no-cache"
    header["Accept-Encoding"] = "gzip"
    if let token = (TaoUserDefaults.standard.object(forKey: TaoUserDefaultKeys.jwtToken.rawValue) as? String), token != ""{
        header["Authorization"] = "Bearer \(token)"
    }

    if let userId = (TaoUserDefaults.standard.object(forKey: TaoUserDefaultKeys.userId.rawValue) as? String), userId != ""{
        header["userid"] = "\(userId)"
    }
    header["version_code"] = "40"
    header["client_type"] = "ios"
    
    return header
}

struct Connectivity {
    static var isConnectedToInternet:Bool {
        return ConnectionManager.is_reachable
    }
}

func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
    switch response.statusCode {
    case 200...299:
        return .success
    case 401:
        return .failure(NetworkResponse.authenticationError.rawValue)
    case 501...599:
        return .failure(NetworkResponse.badRequest.rawValue)
    case 600: return .failure(NetworkResponse.outdated.rawValue)
    default: return .failure(NetworkResponse.failed.rawValue)
    }
}
