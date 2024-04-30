//
//  HomeDetails.swift
//  tao
//
//  Created by Betto Akkara
//

import Foundation
struct HomeDetails : Codable {
    
    let notificationCount : Int?
    let schoolCompetitionList : [Activity]?
    let mediaEntryResponseList : [MediaEntryResponseList]?
    let leaderboardResponse : String?
    let activityList : [Activity]?
    let culturalCompetitions : [Activity]?
    let allCompetitionResponseList : [AllCompetitionResponseList]?
    let academicCompetitions : [AcademicCompetitions]?
    let userWalletResponse : UserWalletResponse?
    let upcomingCompetitionList : [Activity]?
    let widgets : [Widgets]?
    let workshops : [String]?
}

// MARK: - Welcome
struct Banners: Codable {
    let middleBanner: [Banner]?
    let sotdBanner: Banner?
    let staticBanners, topBanners: [Banner]?
}

// MARK: - Banner
struct Banner: Codable {
    let active: Bool?
    let audienceIDS: [Int]?
    let background, cta: String?
    let endTime, id, imageUrl, link: String?
    let linkType: String?
    let maxAppVersion, minAppVersion: Int?
    let name: String?
    let priority: Int?
    let screenType, startTime, subText, subType: String?
    let text, type: String?
}
