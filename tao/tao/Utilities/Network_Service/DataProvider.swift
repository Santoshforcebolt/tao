//
//  APIDataProvider.swift
//  creditcardapp
//
//  Created by Betto Akkara on 22/09/21.
//

import Foundation
//test1

enum APINetworkEndPoint {

    case getOtp(header: HTTPHeaders?, bodyParam: HTTPBody?, urlParam: HTTPQueryParameter?)
    case validateOtp(header: HTTPHeaders?, bodyParam: HTTPBody?, urlParam: HTTPQueryParameter?)
    case user_create(header: HTTPHeaders?, bodyParam: HTTPBody?, urlParam: HTTPQueryParameter?)
    case school_create(header: HTTPHeaders?, bodyParam: HTTPBody?, urlParam: HTTPQueryParameter?)
    case userDetails(header: HTTPHeaders?, bodyParam: HTTPBody?, urlParam: HTTPQueryParameter?)
    case searchLocation(header: HTTPHeaders?, bodyParam: HTTPBody?, urlParam: HTTPQueryParameter?)
    
    // Home
    case getAppConfig(header: HTTPHeaders?, bodyParam: HTTPBody?, urlParam: HTTPQueryParameter?)
    case getCompetitionCategories(header: HTTPHeaders?, bodyParam: HTTPBody?, urlParam: HTTPQueryParameter?)
    case getHomePageDetails(header: HTTPHeaders?, bodyParam: HTTPBody?, urlParam: HTTPQueryParameter?)
    
    // Competition
    case getCompRewardRule(header: HTTPHeaders?, bodyParam: HTTPBody?, urlParam: HTTPQueryParameter?)
    case getCompEntries(header: HTTPHeaders?, bodyParam: HTTPBody?, urlParam: HTTPQueryParameter?)
    case getParticipation(header: HTTPHeaders?, bodyParam: HTTPBody?, urlParam: HTTPQueryParameter?)
    case participation_create(header: HTTPHeaders?, bodyParam: HTTPBody?, urlParam: HTTPQueryParameter?)
    case getCompetitionLeaderboard(header: HTTPHeaders?, bodyParam: HTTPBody?, urlParam: HTTPQueryParameter?)
    
    
}

extension APINetworkEndPoint: EndPointType {

    var path: String {
        switch self {
        case .getOtp: return "api/login/otp"
        case .validateOtp: return "api/login/otp/validate"
        case .user_create: return "api/v1/userprofile/update/\(TaoHelper.userID ?? "")"
        case .school_create: return "api/v1/school/user/create"
        case .getAppConfig: return "api/v1/config/app"
        case .getCompetitionCategories: return "api/v1/category-data/getAll"
        case .getHomePageDetails: return "api/v2/homepage/get"
        case .getCompRewardRule: return "api/v1/competition/getCompRewardRule"
        case .getCompetitionLeaderboard: return "api/v2/leaderboard/competition/\(TaoHelper.competitionId ?? "")"
        case .getCompEntries: return "api/v1/participation/getCompEntries/\(TaoHelper.competitionId ?? "")"
        case .getParticipation: return "api/v1/participation/stats"
        case .participation_create: return "api/v1/participation/create"
        case .userDetails: return "api/v1/userprofile/\(TaoHelper.userID ?? "")"
        case .searchLocation:
            return "api/v1/location/search"
        }
    }

    
    var httpMethod: HTTPMethod {
        switch self {
        case .getOtp,
                .getAppConfig,
                .getCompetitionCategories,
                .getCompRewardRule,
                .getCompEntries,
                .getParticipation,
                .userDetails,
                .getCompetitionLeaderboard,
                .getHomePageDetails:
            return .get
        case .validateOtp,
                .user_create,
                .searchLocation,
                .participation_create,
                .school_create
            
            :
            return .post
        }
    }

    var task: HTTPTask {
        switch self {

        case .getOtp(_, let bodyParams, let urlParams),
                .getAppConfig(_, let bodyParams, let urlParams),
                .getCompetitionCategories(_, let bodyParams, let urlParams),
                .getHomePageDetails(_, let bodyParams, let urlParams),
                .getCompRewardRule(_, let bodyParams, let urlParams),
                .getCompEntries(_, let bodyParams, let urlParams),
                .getParticipation(_, let bodyParams, let urlParams),
                .getCompetitionLeaderboard(_, let bodyParams, let urlParams),
                .userDetails(_, let bodyParams, let urlParams)
            :
            
            return .requestParameters(bodyParameters: bodyParams,
                                      bodyEncoding: ParameterEncoding.urlEncoding,
                                      urlParameters: urlParams)
            
        case .validateOtp(_, let bodyParams, let urlParams):
            
            return .requestParameters(bodyParameters: bodyParams,
                                      bodyEncoding: ParameterEncoding.jsonEncoding,
                                      urlParameters: urlParams)
            
        case .user_create(_, let bodyParams, let urlParams),
                .school_create(_, let bodyParams, let urlParams):
            
            return .requestParameters(bodyParameters: bodyParams,
                                      bodyEncoding: ParameterEncoding.jsonEncoding,
                                      urlParameters: urlParams)
            
        case
                .searchLocation(_, let bodyParams, let urlParams),
                .participation_create(_, let bodyParams, let urlParams)
            :
            
            return .requestParameters(bodyParameters: bodyParams,
                                      bodyEncoding: ParameterEncoding.jsonEncoding,
                                      urlParameters: urlParams)
            
        }

    }

    var headers: HTTPHeaders {
        return coreHeaders()
    }

}

// MARK: - Network Requests
struct APIDataProvider {
    let router = Router<APINetworkEndPoint>()

    static var environment : NetworkEnvironment = .staging

    ///  This api is to generate OTP
    func getOtp(headers header: HTTPHeaders? = nil, bodyParams bodyParam: HTTPBody? = nil  , urlParams urlParam: HTTPQueryParameter? = nil, onSuccess: ((_ success :String?) -> ())?, onError: ((_ error: String?) -> ())?) {
        
        router.requestOtp(mobile: urlParam!["phone"] as! String, onCompletion: onSuccess!)
    }

    ///  This api is to  validate OTP
    func validateOtp(headers header: HTTPHeaders? = nil, bodyParams bodyParam: HTTPBody? = nil  , urlParams urlParam: HTTPQueryParameter? = nil, onSuccess: ((_ success :ValidateOTP_RM?) -> ())?, onError: ((_ error: String?) -> ())?) {

        router.request(APINetworkEndPoint.validateOtp(header: header, bodyParam: bodyParam, urlParam: urlParam)) { data, response, error in
            log(api: #function, param: urlParam, data, error)
            self.handleResponse(data, response, error, onSuccess: onSuccess, onError: onError)
        }

    }

    func getUserDetails(headers header: HTTPHeaders? = nil, bodyParams bodyParam: HTTPBody? = nil  , urlParams urlParam: HTTPQueryParameter? = nil, onSuccess: ((_ success :UserProfile?) -> ())?, onError: ((_ error: String?) -> ())?) {
        router.request(APINetworkEndPoint.userDetails(header: header, bodyParam: bodyParam, urlParam: urlParam)) { data, response, error in
            log(api: #function, param: urlParam, data, error)
            self.handleResponse(data, response, error, onSuccess: onSuccess, onError: onError)
        }
    }
    
    func user_create(headers header: HTTPHeaders? = coreHeaders(), bodyParams bodyParam: HTTPBody? = nil  , urlParams urlParam: HTTPQueryParameter? = nil, onSuccess: ((_ success :Profile_Resp?) -> ())?, onError: ((_ error: String?) -> ())?) {

        router.request(APINetworkEndPoint.user_create(header: header, bodyParam: bodyParam, urlParam: urlParam)) { data, response, error in
            log(api: #function, param: urlParam, data, error)
            self.handleResponse(data, response, error, onSuccess: onSuccess, onError: onError)
        }

    }
    
    func school_create(headers header: HTTPHeaders? = coreHeaders(), bodyParams bodyParam: HTTPBody? = nil  , urlParams urlParam: HTTPQueryParameter? = nil, onSuccess: ((_ success :EmptyResponse?) -> ())?, onError: ((_ error: String?) -> ())?) {

        router.request(APINetworkEndPoint.school_create(header: header, bodyParam: bodyParam, urlParam: urlParam)) { data, response, error in
            log(api: #function, param: urlParam, data, error)
            self.handleResponse(data, response, error, onSuccess: onSuccess, onError: onError)
        }

    }


    ///  This api is to  searchLocation
    func searchLocation(headers header: HTTPHeaders? = coreHeaders(), bodyParams bodyParam: HTTPBody? = nil  , urlParams urlParam: HTTPQueryParameter? = nil, onSuccess: ((_ response :SearchLocation?) -> ())?, onError: ((_ error: String?) -> ())?) {

        router.request(APINetworkEndPoint.searchLocation(header: header, bodyParam: bodyParam, urlParam: urlParam)) { data, response, error in
            log(api: #function, param: urlParam, data, error)
            self.handleResponse(data, response, error, onSuccess: onSuccess, onError: onError)
        }

    }

    ///  This api is to  validate OTP
    func getAppConfig(headers header: HTTPHeaders? = nil, bodyParams bodyParam: HTTPBody? = nil  , urlParams urlParam: HTTPQueryParameter? = nil, onSuccess: ((_ success :GetAppConfig?) -> ())?, onError: ((_ error: String?) -> ())?) {

        router.request(APINetworkEndPoint.getAppConfig(header: header, bodyParam: bodyParam, urlParam: urlParam)) { data, response, error in
            log(api: #function, param: urlParam, data, error)
            self.handleResponse(data, response, error, onSuccess: onSuccess, onError: onError)
        }

    }

    
    
    func getCompetitionCategories(headers header: HTTPHeaders? = nil, bodyParams bodyParam: HTTPBody? = nil  , urlParams urlParam: HTTPQueryParameter? = nil, onSuccess: ((_ success :CompetitionCategories?) -> ())?, onError: ((_ error: String?) -> ())?) {

        router.request(APINetworkEndPoint.getCompetitionCategories(header: header, bodyParam: bodyParam, urlParam: urlParam)) { data, response, error in
            log(api: #function, param: urlParam, data, error)
            self.handleResponse(data, response, error, onSuccess: onSuccess, onError: onError)
        }

    }
    
    
    
    func getHomePageDetails(headers header: HTTPHeaders? = nil, bodyParams bodyParam: HTTPBody? = nil  , urlParams urlParam: HTTPQueryParameter? = nil, onSuccess: ((_ success :HomeDetails?) -> ())?, onError: ((_ error: String?) -> ())?) {

        router.request(APINetworkEndPoint.getHomePageDetails(header: header, bodyParam: bodyParam, urlParam: urlParam)) { data, response, error in
            log(api: #function, param: urlParam, data, error)
            self.handleResponse(data, response, error, onSuccess: onSuccess, onError: onError)
        }

    }
    
    
    // Competition
    func getParticipation(headers header: HTTPHeaders? = nil, bodyParams bodyParam: HTTPBody? = nil  , urlParams urlParam: HTTPQueryParameter? = nil, onSuccess: ((_ success :Participation?) -> ())?, onError: ((_ error: String?) -> ())?) {
        
        router.request(APINetworkEndPoint.getParticipation(header: header, bodyParam: bodyParam, urlParam: urlParam)) { data, response, error in
            log(api: #function, param: urlParam, data, error)
            self.handleResponse(data, response, error, onSuccess: onSuccess, onError: onError)
        }
    }

    func createParticipation(headers header: HTTPHeaders? = nil, bodyParams bodyParam: HTTPBody? = nil  , urlParams urlParam: HTTPQueryParameter? = nil, onSuccess: ((_ success :Participation?) -> ())?, onError: ((_ error: String?) -> ())?) {
        
        router.request(APINetworkEndPoint.participation_create(header: header, bodyParam: bodyParam, urlParam: urlParam)) { data, response, error in
            log(api: #function, param: urlParam, data, error)
            self.handleResponse(data, response, error, onSuccess: onSuccess, onError: onError)
        }
    }
    
    func getCompRewardRule(headers header: HTTPHeaders? = nil, bodyParams bodyParam: HTTPBody? = nil  , urlParams urlParam: HTTPQueryParameter? = nil, onSuccess: ((_ success :CompetitionRewardRule?) -> ())?, onError: ((_ error: String?) -> ())?) {
        
        router.request(APINetworkEndPoint.getCompRewardRule(header: header, bodyParam: bodyParam, urlParam: urlParam)) { data, response, error in
            log(api: #function, param: urlParam, data, error)
            self.handleResponse(data, response, error, onSuccess: onSuccess, onError: onError)
        }
    }
    
    func getCompetitionLeaderboard(headers header: HTTPHeaders? = nil, bodyParams bodyParam: HTTPBody? = nil  , urlParams urlParam: HTTPQueryParameter? = nil, onSuccess: ((_ success :LeaderBoardCompetition?) -> ())?, onError: ((_ error: String?) -> ())?) {
        
        router.request(APINetworkEndPoint.getCompetitionLeaderboard(header: header, bodyParam: bodyParam, urlParam: urlParam)) { data, response, error in
            log(api: #function, param: urlParam, data, error)
            self.handleResponse(data, response, error, onSuccess: onSuccess, onError: onError)
        }
    }
    
    func getCompEntries(headers header: HTTPHeaders? = nil, bodyParams bodyParam: HTTPBody? = nil  , urlParams urlParam: HTTPQueryParameter? = nil, onSuccess: ((_ success :String?) -> ())?, onError: ((_ error: String?) -> ())?) {
        
        router.request(APINetworkEndPoint.getCompEntries(header: header, bodyParam: bodyParam, urlParam: urlParam)) { data, response, error in
            log(api: #function, param: urlParam, data, error)
            self.handleResponse(data, response, error, onSuccess: onSuccess, onError: onError)
        }

    }
    
}

extension APIDataProvider {
    fileprivate func log(api : String,param : HTTPBody?, _ data: Data?, _ error: Error?) {
        do {
            // make sure this JSON is in the format we expect
            if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {

                // try to read out a string array
                Logger.i("\n*************************** API **************************\n")
                Logger.i("API : \(api)")
                Logger.i("parameters : \n\(param ?? [:])\n")
                Logger.i("data : \(Logger.Print_json(json))")
                Logger.i("Error : \n\(error?.localizedDescription ?? "")\n")
                Logger.i("\n*******************************************************************\n")

            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }

    func handleResponse<T: Decodable>(_ data: Data?,_ response: URLResponse?,_ error: Error?, onSuccess: ((T?) -> ())?, onError: ((_ error: String?) -> ())? ) {

        if error != nil {
            Logger.e(error?.localizedDescription)
            onError?(error?.localizedDescription)
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
                        onError?(error.localizedDescription)
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
                        Router<APINetworkEndPoint>.cancellAllActiveCalls()
                        return
                    }

                default:
                    onError?(networkFailureError)
                }
            }
        }
    }
    
}


// MARK: - Encode/decode helpers

public class JSONNull: Codable, Hashable {

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

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

public class JSONAny: Codable {

    public let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
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

