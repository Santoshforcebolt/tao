//
//  Router.swift
//  tao
//
//  Created by Betto Akkara on 03/02/22.
//
import Foundation
import UIKit
import Security

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?) -> ()


public extension Router {
    class func cancellAllActiveCalls() {
        let session = NetworkManager.sessionManager
        session.getAllTasks(completionHandler: { (tasks) in
            for task in tasks {
                task.cancel()
            }
        })
    }
}

final class NetworkManager {

    static let sessionManager: URLSession = {
        let configuaration = URLSessionConfiguration.ephemeral
        configuaration.timeoutIntervalForResource = 1 * 60.0
        configuaration.waitsForConnectivity = true
        return URLSession(configuration: configuaration);
    }()
    
    static var urlRequestArray: [URLSessionTask] = {
        return [URLSessionTask]()
    }()
    
    static func removeDuplicateRequest(currentRequest: URLSessionTask) {

        var task: URLSessionTask? = nil
        for request in urlRequestArray {
            if (request.originalRequest == currentRequest.originalRequest) {
                task = request
                break
            }
        }

        if task != nil {
            task!.cancel()
            urlRequestArray.remove(object: task!)
        }
    }
}

public protocol NetworkRouter: AnyObject {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

public class Router<EndPoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask!
    
    public init() {
        
    }

    public func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {

        let session = NetworkManager.sessionManager
        do {
            let request = try self.buildRequest(from: route)
            let semaphore = DispatchSemaphore (value: 0)
            Logger.i(request)
            self.task = session.dataTask(with: request) { data, response, error in

                Logger.i(String(data: data!, encoding: .utf8))
                Logger.i(response)

                guard let data = data else {
                    Logger.i(String(describing: error))
                    semaphore.signal()
                    return
                }

                semaphore.signal()
                completion(data, response, error)
            }

            self.task.resume()
            semaphore.wait()

        } catch {

            DispatchQueue.main.async {
                completion(nil, nil, error)
            }

        }

    }
    
    public func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 4 * 60.0)

        request.httpMethod = route.httpMethod.rawValue
        do {
            
            switch route.task {
            case .request:
                Logger.d("route.headers : request")
                Logger.d(route.headers)
                self.addAdditionalHeaders(route.headers, request: &request)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):
                Logger.d("route.headers : requestParameters")
                Logger.d(route.headers)
                self.addAdditionalHeaders(route.headers, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestParametersArray(let bodyParameters,
                                         let bodyEncoding,
                                         let urlParameters):
                self.addAdditionalHeaders(route.headers, request: &request)
                try self.configureParameters(bodyParameters: nil, bodyEncoding: bodyEncoding, bodyArrayParameters: bodyParameters, urlParameters: urlParameters, request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let additionalHeaders):
                self.addAdditionalHeaders(route.headers, request: &request)
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: HTTPBody?,
                                         bodyEncoding: ParameterEncoding,
                                         bodyArrayParameters: HTTPBodyArray? = nil,
                                         urlParameters: HTTPQueryParameter?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters,
                                    bodyArrayParameters: bodyArrayParameters,
                                    urlParameters: urlParameters)

        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}

