//
//  Networkmanager.swift
//  tao
//
//  Created by Betto Akkara on 03/02/22.
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
    case qa
    case production
    case staging
    case uat
}

public func coreHeaders() -> HTTPHeaders {
    var header: HTTPHeaders = [:]
    header["cache-control"] = "no-cache"
    header["accept"] = "application/json"
    if let token = (TaoUserDefaults.standard.object(forKey: TaoUserDefaultKeys.jwtToken.rawValue) as? String), token != ""{
        header["authorization"] = "Bearer \(token)"
    }
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
