//
//  validateOTP_ResponseModel.swift
//  tao
//
//  Created by Betto Akkara on 02/03/22.
//

import Foundation
struct ValidateOTP_RM: Codable {
    let phone: String?
    let success: Bool?
    let userID: String?
    let token: String?
    let refreshToken: String?
    let profileCreated: Bool?

    enum CodingKeys: String, CodingKey {
        case phone = "phone"
        case success = "success"
        case userID = "userId"
        case token = "token"
        case refreshToken = "refreshToken"
        case profileCreated = "profileCreated"
    }
    
}
