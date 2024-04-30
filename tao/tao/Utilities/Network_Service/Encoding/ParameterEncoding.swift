//
//  ParameterEncoding.swift
//  creditcardapp
//
//  Created by Betto Akkara on 22/09/21.
//
import Foundation

public typealias Parameters = [String: Any?]

protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum ParameterEncoding {
    
    case urlEncoding
    case jsonEncoding
    case urlAndJsonEncoding
    
    func encode(urlRequest: inout URLRequest,
                       bodyParameters: HTTPBody?,
                       bodyArrayParameters: HTTPBodyArray?,
                       urlParameters: HTTPQueryParameter?) throws {
        do {
            switch self {
            case .urlEncoding:
                guard let urlParameters = urlParameters else { return }
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                
            case .jsonEncoding:
                if let bodyParameters = bodyParameters {
                    try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
                } else if let bodyParameters = bodyArrayParameters {
                    try JSONParameterEncoder().encodeArray(urlRequest: &urlRequest, with: bodyParameters)
                } else { return }
                
            case .urlAndJsonEncoding:
                guard let bodyParameters = bodyParameters,
                    let urlParameters = urlParameters else { return }
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
                
            }
        } catch {
            throw error
        }
    }
}



enum NetworkError : String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}
