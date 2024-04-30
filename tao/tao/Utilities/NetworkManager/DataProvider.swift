//
//  DataProvider.swift
//  tao
//
//  Created by Betto Akkara on 03/02/22.
//

import Foundation

enum TaoNetworkEndPoint {

    case getOtp(header: HTTPHeaders?, bodyParam: HTTPBody?, urlParam: HTTPQueryParameter?)
    case validateOtp(header: HTTPHeaders?, bodyParam: HTTPBody?, urlParam: HTTPQueryParameter?)
    case user_create(header: HTTPHeaders?, bodyParam: HTTPBody?, urlParam: HTTPQueryParameter?)
    case searchLocation(header: HTTPHeaders?, bodyParam: HTTPBody?, urlParam: HTTPQueryParameter?)


}

extension TaoNetworkEndPoint: EndPointType {

    var path: String {
        switch self {
        case .getOtp: return "api/login/otp"
        case .validateOtp: return "api/login/otp/validate"
        case .user_create: return "api/v1/user/create"
        case .searchLocation: return "api​/v1​/location​/search"
        }

    }





    var httpMethod: HTTPMethod {
        switch self {
        case
                .getOtp

            :

            return .get

        case
                .validateOtp,
                .user_create,
                .searchLocation

            :

            return .post
        }
    }

    var task: HTTPTask {
        switch self {
        case .getOtp(_, _, let urlParam):
            return .requestParameters(bodyParameters: nil, bodyEncoding: ParameterEncoding.urlEncoding, urlParameters: urlParam)
        case .validateOtp(_, bodyParam: let bodyParam, urlParam: let urlParam):
            return .requestParameters(bodyParameters: bodyParam, bodyEncoding: ParameterEncoding.jsonEncoding, urlParameters: urlParam)
        case .user_create(_, bodyParam: let bodyParam, urlParam: let urlParam):
            return .requestParameters(bodyParameters: bodyParam, bodyEncoding: ParameterEncoding.jsonEncoding, urlParameters: urlParam)
        case .searchLocation(_, bodyParam: let bodyParam, urlParam: let urlParam):
            return .requestParameters(bodyParameters: bodyParam, bodyEncoding: ParameterEncoding.jsonEncoding, urlParameters: urlParam)
        }

    }

    var headers: HTTPHeaders {
        return coreHeaders()
    }
}

// MARK: - Network Requests
struct DataProvider {
    let router = Router<TaoNetworkEndPoint>()

    static var environment : NetworkEnvironment = AppController.manager().networkEnvironment

    ///  This api is to generate OTP
    func getOtp(headers header: HTTPHeaders? = nil, bodyParams bodyParam: HTTPBody? = nil  , urlParams urlParam: HTTPQueryParameter? = nil, onSuccess: ((_ success :String?) -> ())?, onError: ((_ error: String?) -> ())?) {

        router.request(TaoNetworkEndPoint.getOtp(header: header, bodyParam: bodyParam, urlParam: urlParam)) { data, response, error in
            log(api: #function, param: urlParam, data, error)
            self.handleResponse(data, response, error, onSuccess: onSuccess, onError: onError)
        }

    }

    ///  This api is to  validate OTP
    func validateOtp(headers header: HTTPHeaders? = nil, bodyParams bodyParam: HTTPBody? = nil  , urlParams urlParam: HTTPQueryParameter? = nil, onSuccess: ((_ success :ValidateOTP_RM?) -> ())?, onError: ((_ error: String?) -> ())?) {

        router.request(TaoNetworkEndPoint.validateOtp(header: header, bodyParam: bodyParam, urlParam: urlParam)) { data, response, error in
            log(api: #function, param: urlParam, data, error)
            self.handleResponse(data, response, error, onSuccess: onSuccess, onError: onError)
        }

    }

    func user_create(headers header: HTTPHeaders? = coreHeaders(), bodyParams bodyParam: HTTPBody? = nil  , urlParams urlParam: HTTPQueryParameter? = nil, onSuccess: ((_ success :Profile_Resp?) -> ())?, onError: ((_ error: String?) -> ())?) {

        router.request(TaoNetworkEndPoint.user_create(header: header, bodyParam: bodyParam, urlParam: urlParam)) { data, response, error in
            log(api: #function, param: urlParam, data, error)
            self.handleResponse(data, response, error, onSuccess: onSuccess, onError: onError)
        }

    }


    ///  This api is to  searchLocation
    func searchLocation(headers header: HTTPHeaders? = coreHeaders(), bodyParams bodyParam: HTTPBody? = nil  , urlParams urlParam: HTTPQueryParameter? = nil, onSuccess: ((_ response :SearchLocation?) -> ())?, onError: ((_ error: String?) -> ())?) {

        router.request(TaoNetworkEndPoint.searchLocation(header: header, bodyParam: bodyParam, urlParam: urlParam)) { data, response, error in
            log(api: #function, param: urlParam, data, error)
            self.handleResponse(data, response, error, onSuccess: onSuccess, onError: onError)
        }

    }



}

extension DataProvider {
    fileprivate func log(api : String,param : HTTPBody?, _ data: Data?, _ error: Error?) {
        do {
            // make sure this JSON is in the format we expect
            if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                // try to read out a string array
                Logger.i("\n*************************** API **************************\n")
                Logger.i("API : \(api)")
                Logger.i("parameters : \n\(param)\n")
                Logger.i("data : \(Logger.Print_json(json))")
                Logger.i("Error : \n\(error?.localizedDescription ?? "")\n")
                Logger.i("\n*******************************************************************\n")

            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }

    func handleResponse<T: Codable>(_ data: Data?,_ response: URLResponse?,_ error: Error?, onSuccess: ((T?) -> ())?, onError: ((_ error: String?) -> ())? ) {

        if error != nil {
            onError?(error?.localizedDescription)
            Logger.e(error?.localizedDescription ?? "")
        }

        if let response = response as? HTTPURLResponse {
            let result = handleNetworkResponse(response)
            switch result {
            case .success:
                guard let responseData = data else {
                    onError?(NetworkResponse.noData.rawValue)
                    return
                }
                if responseData.count > 0 {
                    do{
                        let decodedJson = try newJSONDecoder().decode(T.self, from: responseData)
                        onSuccess?(decodedJson)
                    }catch{

                        Logger.e(error)
                        if let data_ = String(data: responseData, encoding: .utf8), !(data_.isEmpty){
                            onSuccess?(data_ as! T)
                        }else{
                            onError?(error.localizedDescription)
                        }

                    }
                }
                else {
                    onError?(NetworkResponse.unableToDecode.rawValue)
                    onSuccess?(nil)
                }
            case .failure(let networkFailureError):
                switch networkFailureError {
                case NetworkResponse.authenticationError.rawValue:
                    DispatchQueue.main.async {
                        Router<TaoNetworkEndPoint>.cancellAllActiveCalls()
                        return
                    }

                default:
                    onError?(networkFailureError)
                }
            }
        }
    }
}


// MARK: Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
