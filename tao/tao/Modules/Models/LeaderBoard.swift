//
//  LeaderBoard.swift
//  tao
//
//  Created by Mayank Khursija on 01/07/22.
//

import Foundation

struct LeaderBoardData: Codable {
    var leaderboard: [LeaderBoard]?
    var userLeaderboardResponse: LeaderBoard?
    var rewardType: String?
}

struct LeaderBoard: Codable {
    var userId: String?
    var imageUrl: String?
    var reward: Int?
    var username: String?
    var rank: Int?
    var school: NewSchoolInfo?
    var competitionDetails: [CompetitionDetails]?
}

struct CompetitionDetails: Codable {
    var id: String?
    var name: String?
    var points: Double?
}

struct LeaderBoardCompetition: Codable {
    var leaderboardData: [LeaderBoard]?
    var rewardType: String?
}
