//
//  createUserProfileDataModel.swift
//  tao
//
//  Created by Betto Akkara on 03/03/22.
//

import Foundation

let createProfile = Profile()

class Profile {
    var autoSubscribe: Bool = true
    var bio: String = ""
    var dateOfBirth: String?
    var email: String = ""
    var firstName: String?
    var gender: String?
    var imageURL: String = ""
    var lastName: String?
    var location: Location?
    var referredBy: String = ""
    var schoolInfo: SchoolInfo?
    var subscribedPlan: SubscribedPlan?
    var userType: String = ""
}

// MARK: - Location
class Location {
    var city: String?
    var created: String?
    var id: String?
    var pin: String?
    var pinPrefix: String?
    var searchData: String?
    var state: String?
}

// MARK: - SchoolInfo
class SchoolInfo {
    var schoolID: String?
    var schoolName: String?
    var standard: String?
}

class SchoolInfoForCreate {
    var schoolID: String?
    var schoolName: String?
    var standard: String?
    var city: String?
    var locationId: String?
    var state: String?
    var pin: String?
}

// MARK: - SubscribedPlan
class SubscribedPlan {
    var code: String?
    var discountedPrice: Int?
    var durationDays: Int?
    var id: String?
    var monthlyPayoutEligible: Bool?
    var name: String?
    var price: Int?
    var rewardType: String?
    var status: String?
    var subType: String?
    var type: String?
    var weeklyPayoutEligible: Bool?
}




///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///                             Response Model - Profile

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





// MARK: - Response Model - Profile
struct Profile_Resp: Codable {
    var body: RespBody?
    var debugMessage: String?
    var errorMessage: [String]?
    var internalCode: String?
    var message: String?
    var meta: Meta?
    var status: Int?

    enum CodingKeys: String, CodingKey {
        case body = "body"
        case debugMessage = "debugMessage"
        case errorMessage = "errorMessage"
        case internalCode = "internalCode"
        case message = "message"
        case meta = "meta"
        case status = "status"
    }
}

// MARK: - Body
struct RespBody: Codable {
    var autoSubscribe: Bool?
    var bio: String?
    var children: [Child]?
    var dateOfBirth: String?
    var email: String?
    var firstName: String?
    var gender: String?
    var id: String?
    var isPremiumUser: Bool?
    var isVerified: Bool?
    var lastName: String?
    var parentID: String?
    var phone: String?
    var planDetails: RespPlanDetails?
    var schoolInfo: RespSchoolInfo?
    var type: String?
    var username: String?

    enum CodingKeys: String, CodingKey {
        case autoSubscribe = "autoSubscribe"
        case bio = "bio"
        case children = "children"
        case dateOfBirth = "dateOfBirth"
        case email = "email"
        case firstName = "firstName"
        case gender = "gender"
        case id = "id"
        case isPremiumUser = "isPremiumUser"
        case isVerified = "isVerified"
        case lastName = "lastName"
        case parentID = "parentId"
        case phone = "phone"
        case planDetails = "planDetails"
        case schoolInfo = "schoolInfo"
        case type = "type"
        case username = "username"
    }
}

// MARK: - Child
struct Child: Codable {
    var autoSubscribe: Bool?
    var bio: String?
    var createdTimestamp: String?
    var dateOfBirth: String?
    var email: String?
    var firstName: String?
    var freeTrialEligible: Bool?
    var gender: String?
    var id: String?
    var imageURL: String?
    var isPremiumUser: Bool?
    var isReferred: Bool?
    var isVerified: Bool?
    var lastName: String?
    var lastParticipationOn: String?
    var location: RespLocation?
    var numCompetitionsParticipated: Int?
    var numEntriesEvaluated: Int?
    var phone: String?
    var referCode: String?
    var referralCount: Int?
    var reportedCount: Int?
    var schoolInfo: RespSchoolInfo?
    var skills: [String]?
    var studentAmbassador: Bool?
    var subscribedPlan: RespPlanDetails?
    var totalReferralCoins: Int?
    var type: String?
    var updatedTimestamp: String?
    var username: String?

    enum CodingKeys: String, CodingKey {
        case autoSubscribe = "autoSubscribe"
        case bio = "bio"
        case createdTimestamp = "createdTimestamp"
        case dateOfBirth = "dateOfBirth"
        case email = "email"
        case firstName = "firstName"
        case freeTrialEligible = "freeTrialEligible"
        case gender = "gender"
        case id = "id"
        case imageURL = "imageUrl"
        case isPremiumUser = "isPremiumUser"
        case isReferred = "isReferred"
        case isVerified = "isVerified"
        case lastName = "lastName"
        case lastParticipationOn = "lastParticipationOn"
        case location = "location"
        case numCompetitionsParticipated = "numCompetitionsParticipated"
        case numEntriesEvaluated = "numEntriesEvaluated"
        case phone = "phone"
        case referCode = "referCode"
        case referralCount = "referralCount"
        case reportedCount = "reportedCount"
        case schoolInfo = "schoolInfo"
        case skills = "skills"
        case studentAmbassador = "studentAmbassador"
        case subscribedPlan = "subscribedPlan"
        case totalReferralCoins = "totalReferralCoins"
        case type = "type"
        case updatedTimestamp = "updatedTimestamp"
        case username = "username"
    }
}

// MARK: - Location
struct RespLocation: Codable {
    var city: String?
    var created: String?
    var id: String?
    var pin: String?
    var pinPrefix: String?
    var searchData: String?
    var state: String?

    enum CodingKeys: String, CodingKey {
        case city = "city"
        case created = "created"
        case id = "id"
        case pin = "pin"
        case pinPrefix = "pinPrefix"
        case searchData = "searchData"
        case state = "state"
    }
}

// MARK: - SchoolInfo
struct RespSchoolInfo: Codable {
    var schoolID: String?
    var schoolName: String?
    var standard: String?

    enum CodingKeys: String, CodingKey {
        case schoolID = "schoolId"
        case schoolName = "schoolName"
        case standard = "standard"
    }
}

// MARK: - PlanDetails
struct RespPlanDetails: Codable {
    var code: String?
    var discountedPrice: Int?
    var durationDays: Int?
    var id: String?
    var monthlyPayoutEligible: Bool?
    var name: String?
    var price: Int?
    var rewardType: String?
    var status: String?
    var subType: String?
    var type: String?
    var weeklyPayoutEligible: Bool?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case discountedPrice = "discountedPrice"
        case durationDays = "durationDays"
        case id = "id"
        case monthlyPayoutEligible = "monthlyPayoutEligible"
        case name = "name"
        case price = "price"
        case rewardType = "rewardType"
        case status = "status"
        case subType = "subType"
        case type = "type"
        case weeklyPayoutEligible = "weeklyPayoutEligible"
    }
}

// MARK: - Meta
struct Meta: Codable {
    var empty: Bool?

    enum CodingKeys: String, CodingKey {
        case empty = "empty"
    }
}

struct CreateSchool: Codable {
    var city: String?
    var name: String?
}

struct Referrals: Codable {
    let code, cursor: String?
    let entriesJudged, referralCount: Int?
    var referrals: [Referral]?
    let totalCoins: Int?
}

// MARK: - Referral
struct Referral: Codable {
    let coins: Int?
    let completed: Bool?
    let name: String?
    let status: Int?
    let userID: String?

    enum CodingKeys: String, CodingKey {
        case coins, completed, name, status
        case userID
    }
}

struct ReferralsData: Codable {
    let code, imageUrl, shareLink: String?
    let studentAmbassador: Bool?
    let studentAmbassadorStatus, text: String?
    let widget: ReferralData?

    enum CodingKeys: String, CodingKey {
        case code
        case imageUrl
        case shareLink, studentAmbassador, studentAmbassadorStatus, text, widget
    }
}

// MARK: - Widget
struct ReferralData: Codable {
    let active: Bool?
    let audienceIDS: [Int]?
    let background, cta: String?
    let endTime, id, imageURL, link: String?
    let linkType: String?
    let maxAppVersion, minAppVersion: Int?
    let name: String?
    let priority: Int?
    let screenType, startTime, subText, subType: String?
    let text, type: String?

    enum CodingKeys: String, CodingKey {
        case active
        case audienceIDS
        case background, cta, endTime, id
        case imageURL
        case link, linkType, maxAppVersion, minAppVersion, name, priority, screenType, startTime, subText, subType, text, type
    }
}
