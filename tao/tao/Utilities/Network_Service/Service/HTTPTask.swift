//
//  HTTPTask.swift
//  creditcardapp
//
//  Created by Betto Akkara on 22/09/21.
//

import Foundation

public typealias HTTPHeaders = [String: String]
public typealias HTTPBody = [String: Any]
public typealias HTTPBodyArray = [String]
public typealias HTTPQueryParameter = [String: Any]

public enum HTTPTask {
    case request
    
    case requestParameters(bodyParameters: HTTPBody?,
        bodyEncoding: ParameterEncoding,
        urlParameters: HTTPQueryParameter?)
    
    case requestParametersArray(bodyParametersArray: HTTPBodyArray?,
        bodyEncoding: ParameterEncoding,
        urlParameters: HTTPQueryParameter?)
    
    case requestParametersAndHeaders(bodyParameters: HTTPBody?,
        bodyEncoding: ParameterEncoding,
        urlParameters: HTTPQueryParameter?,
        additionHeaders: HTTPHeaders?)
}
