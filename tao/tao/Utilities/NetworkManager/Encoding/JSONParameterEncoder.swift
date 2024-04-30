//
//  JSONParameterEncoder.swift
//  tao
//
//  Created by Betto Akkara on 03/02/22.
//
import Foundation

struct JSONParameterEncoder: ParameterEncoder {
     func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {

            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)

            // TODO:  in production mode use encrypted payload
            urlRequest.httpBody = jsonAsData

            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
        }catch {
            throw NetworkError.encodingFailed
        }
    }
    
    func encodeArray(urlRequest: inout URLRequest, with parameters: [String?]) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }catch {
            throw NetworkError.encodingFailed
        }
    }
}
