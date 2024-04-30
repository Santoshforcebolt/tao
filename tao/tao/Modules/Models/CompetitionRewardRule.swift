//
//  CompetitionRewardRule.swift
//  tao
//
//  Created by Mayank Khursija on 07/08/22.
//

import Foundation

struct CompetitionRewardRule: Codable {
    var body: CompetitionRewardRuleBody?
}

struct CompetitionRewardRuleBody: Codable {
    var rewardType: String?
    var rewards: [CompetitionReward]?
    
}

struct CompetitionReward: Codable {
    var startRank: Int?
    var endRank: Int?
    var winnings: Int?
}

struct CompetitionData: Codable {
    var imageUrl: String?
    var name: String?
    var rewardType: String?
    var prize: Int?
    var description: String?
}

// MARK: - Welcome
struct MyCompetitions: Codable {
    var body: Body?
    let debugMessage: String?
    let errorMessage: [String]?
    let internalCode, message: String?
    let status: Int?
}

// MARK: - Body
struct Body: Codable {
    let cursor: String?
    var data: [MyCompetition]?
    let hasNext, hasPrevious: Bool?
    let nextCursor, previousCursor: String?
}

// MARK: - Datum
struct MyCompetition: Codable {
    let activity: Bool?
    let certificateLink, certificateType, competitionId, competitionImage: String?
    let competitionName, competitionStatus: String?
    let currentPosition: Int?
    let endTimestamp, participationID: String?
    let prize, reward: Float?
    let rewardType, startTimestamp, status: String?

    enum CodingKeys: String, CodingKey {
        case activity, certificateLink, certificateType
        case competitionId
        case competitionImage, competitionName, competitionStatus, currentPosition, endTimestamp
        case participationID
        case prize, reward, rewardType, startTimestamp, status
    }
}

struct CompetitionEntries: Codable {
    var body: CompetitionEntryBody?
    let debugMessage: String?
    let errorMessage: [String]?
    let internalCode, message: String?
    let status: Int?
}

// MARK: - Body
struct CompetitionEntryBody: Codable {
    let cursor: String?
    var data: [CompetitionEntry]?
    let hasNext, hasPrevious: Bool?
    let nextCursor, previousCursor: String?
}

// MARK: - Datum
struct CompetitionEntry: Codable {
    let badges: Badges?
    let blocked: Bool?
    let competitionCategory, competitionID, competitionName, competitionSubCategory: String?
    let description: String?
    let exploreScore: Int?
    let hex, id: String?
    let likes: Int?
    let mediaStatus, mediaType, name, participantName: String?
    let reported: Bool?
    let resourceURL: String?
    let shares: Int?
    let story: Bool?
    let submittedTimestamp, thumbnailURL, userID: String?
    let userLiked, userShared: Bool?
    let views: Int?

    enum CodingKeys: String, CodingKey {
        case badges, blocked, competitionCategory
        case competitionID
        case competitionName, competitionSubCategory
        case description
        case exploreScore, hex, id, likes, mediaStatus, mediaType, name, participantName, reported, resourceURL, shares, story, submittedTimestamp, thumbnailURL
        case userID
        case userLiked, userShared, views
    }
}

// MARK: - Badges
struct Badges: Codable {
    let badgesDescription, hex, name, template: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case badgesDescription
        case hex, name, template, url
    }
}

struct CertificateData: Codable {
    var certificateLink: String?
}

struct CateogryCompetitions: Codable {
    let activityList: [ActivityList]?
    let categoryResponse: CategoryResponse?
    let competitions: [ActivityList]?
    let cursor: String?
    let onGoingCompetitions, previousCompetitions: [ActivityList]?
    let roundDescription: String?
    let roundStarted: Bool?
    let upComingCompetitions: [ActivityList]?
}

// MARK: - ActivityList
struct ActivityList: Codable {
    let activity: Bool?
    let background, categoryImage, categoryType: String?
    let certificateGenerated: Bool?
    let contentMaxDuration: Int?
    let createdTimeStamp: String?
    let activityListDescription: String?
    let eligible: Bool?
    let endTime: String?
    let entryFee: Int?
    let evaluationDetails: EvaluationDetails?
    let guide: [Total]?
    let id, imageURL, leaderboardType: String?
    let maxAge, maxParticipants: Int?
    let mediaType: String?
    let minAge, minParticipants: Int?
    let name: String?
    let paid: Bool?
    let participationCloseTime: String?
    let participationCount, priority: Int?
    let activityListPrivate: Bool?
    let prize: Int?
    let questionCriteria: QuestionCriteria?
    let quizQuirks: QuizQuirks?
    let rewardRuleID: String?
    let rewardType: String?
    let sample: String?
    let showMaxParticipation: Bool?
    let sponsorDetails: String?
    let standards: [Int]?
    let startTime, status: String?
    let subCategory, subType, type: String?
    let updatedTimeStamp: String?

    enum CodingKeys: String, CodingKey {
        case activity, background, categoryImage, categoryType, certificateGenerated, contentMaxDuration, createdTimeStamp
        case activityListDescription
        case eligible, endTime, entryFee, evaluationDetails, guide, id
        case imageURL
        case leaderboardType, maxAge, maxParticipants, mediaType, minAge, minParticipants, name, paid, participationCloseTime, participationCount, priority
        case activityListPrivate
        case prize, questionCriteria, quizQuirks
        case rewardRuleID
        case rewardType, sample, showMaxParticipation, sponsorDetails, standards, startTime, status, subCategory, subType, type, updatedTimeStamp
    }
}

// MARK: - QuizQuirks
struct QuizQuirks: Codable {
    let additionalProp1, additionalProp2, additionalProp3: Int?
}

// MARK: - CategoryResponse
struct CategoryResponse: Codable {
    let backgroundColor: String?
    let baseAudienceID: Int?
    let category: String?
    let competitionCount: Int?
    let categoryResponseDescription, id, imageURL, imageV2: String?
    let nextRoundEligble: Bool?
    let nslAudiences: [Int]?
    let participationCount, priority, rank, round: Int?
    let roundClosed, roundEligible: Bool?
    let school, state, subCategory, subType: String?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case backgroundColor
        case baseAudienceID
        case category, competitionCount
        case categoryResponseDescription
        case id
        case imageURL
        case imageV2, nextRoundEligble, nslAudiences, participationCount, priority, rank, round, roundClosed, roundEligible, school, state, subCategory, subType, type
    }
}
