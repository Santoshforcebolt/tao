//
//  QuizQuestion.swift
//  tao
//
//  Created by Mayank Khursija on 10/08/22.
//

import Foundation

// MARK: - Welcome
struct QuizQuestions: Codable {
    let body: [QuizQuestion]?
    let debugMessage: String?
    let errorMessage: [String]?
    let internalCode, message: String?
    let status: Int?
}

// MARK: - Body
struct QuizQuestion: Codable {
    let created, difficultyLevel, id, imageURL: String?
    let inputAnswer: String?
    let isActive, isInputType, isMCQType: Bool?
    let maxPoints: Int?
    let mcqOptions: [McqOption]?
    let questionDescription, questionText, standard, subject: String?
    let tags: [String]?
    let timeLimit: Int?
    let timeLimitUnit: String?
    let topics: [String]?

    enum CodingKeys: String, CodingKey {
        case created, difficultyLevel, id
        case imageURL = "imageUrl"
        case inputAnswer, isActive, isInputType, isMCQType, maxPoints, mcqOptions, questionDescription, questionText, standard, subject, tags, timeLimit, timeLimitUnit, topics
    }
}

// MARK: - McqOption
struct McqOption: Codable {
    let fiftyFifty: Bool?
    let identifier: String?
    let isCorrect: Bool?
    let text: String?
}

// MARK: - Welcome
struct Evaluation: Codable {
    let body: Score?
    let debugMessage: String?
    let errorMessage: [String]?
    let internalCode, message: String?
    let status: Int?
}

// MARK: - Body
struct Score: Codable {
    let competitionID: String?
    let criticScore, engagementScore: Float?
    let participationID: String?
    let responseScore, timeScore, totalScore: Float?
    let userID: String?

    enum CodingKeys: String, CodingKey {
        case competitionID
        case criticScore, engagementScore
        case participationID
        case responseScore, timeScore, totalScore
        case userID
    }
}
