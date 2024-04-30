//
//  EndPointType.swift
//  creditcardapp
//
//  Created by Betto Akkara on 22/09/21.
//

import Foundation

public enum CachePolicy {
    case nocache
    case `default`
}

public protocol EndPointType {
    
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders { get }
    var cachePolicy: CachePolicy { get }
}

extension EndPointType {
    var baseURL: URL {
        guard let url = URL(string: AppController.shared.getBaseURL()) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var cachePolicy: CachePolicy {
        return .nocache
    }
}
