//
//  EndPointType.swift
//  tao
//
//  Created by Betto Akkara on 03/02/22.
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
        guard let url = URL(string: AppController.manager().getBaseURL()) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var cachePolicy: CachePolicy {
        return .nocache
    }
}
