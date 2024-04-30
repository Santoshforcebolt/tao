//
//  UserProfile.swift
//  tao
//
//  Created by Mayank Khursija on 25/05/22.
//

import Foundation

struct UserProfile: Codable {
    var userDetails: UserDetails?
    var userRewardHistory: UserRewardHistory?
    var userSocialStatResponse: UserSocialStatResponse?
    var userSubscriptionDetails: UserSubscriptionDetails?
    var walletResponse: WalletResponse?
}

struct UserDetails: Codable {
    var autoSubscribe: Bool?
    var bio: String?
    var competitionCount: Int?
    var dateOfBirth: String?
    var email: String?
    var firstName: String?
    var freeTrialEligible: Bool?
    var gender: String?
    var imageUrl: String?
    var isPremiumUser: Bool?
    var isVerified: Bool?
    var lastName: String?
    var lastParticipatedOn: String?
    var phone: String?
    var profileLocked: Bool?
    var referralCode: String?
    var referralCount: Int?
    var schoolInfo: NewSchoolInfo?
    var type: String?
    var userId: String?
    var username: String?
}

struct UserRewardHistory: Codable {
    var cash: Double?
    var coins: Double?
    var image: String?
    var school: String?
    var standard: String?
    var userId: String?
    var userName: String?
    var walletId: Int?
}

struct UserSocialStatResponse: Codable {
    var follower: Int?
    var following: Int?
    var userId: String?
}

struct UserSubscriptionDetails: Codable {
    var autoSubscribed: Bool?
    var charges: String?
    var isSubscribed: Bool?
    var planDetails: PlanDetails?
    var subscriptionDetails: SubscriptionDetails?
}

struct WalletResponse: Codable {
    var balanceDetails: BalanceDetails?
    var status: String?
    var userId: String?
    var walletId: Int?
}

struct NewSchoolInfo: Codable {
    var schoolId: String?
    var schoolName: String?
    var standard: String?
}

struct PlanDetails: Codable {
    var code: String?
    var discountedPrice: Double?
    var durationDays: Int?
    var id: String?
    var monthlyPayoutEligible: Bool?
    var name: String?
    var price: Double?
    var rewardType: String?
    var status: String?
    var subType: String?
    var type: String?
    var weeklyPayoutEligible: Bool?
}

struct SubscriptionDetails: Codable {
    var amountPaid: Double?
    var endDate: String?
    var expiredOn: String?
    var id: String?
    var originalAmount: Double?
    var planType: String?
    var premiumPlanId: String?
    var startDate: String?
    var status: String?
    var userId: String?
}

struct VisitProfile: Codable {
    var blocked: Bool?
    var coins: Double?
    var competitions: Int?
    var followed: Bool?
    var following: Bool?
    var handle: String?
    var hasBlocked: Bool?
    var myTaoUrl: String?
    var profileImage: String?
    var school: String?
    var userId: String?
    var userRewardHistory: UserRewardHistory?
    var userSocialStatResponse: UserSocialStatResponse?
    var username: String?
    var verified: Bool?
}

struct SubscriptionPlans: Codable {
    var body: [PlanDetails]?
}

struct InTransitOrder: Codable {
    var orderId: String?
    var orderStatus: String?
    var partnerKeyId: String?
    var partnerOrderId: String?
    var paymentStatus: String?
    var productId: String?
    var userId: String?
}
