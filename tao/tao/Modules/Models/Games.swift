//
//  Games.swift
//  tao
//
//  Created by Mayank Khursija on 07/09/22.
//

import Foundation

struct Games: Codable {
    let games: [Game]?
}

// MARK: - Game
struct Game: Codable {
    let active: Bool?
    let gameDescription, id, image, name: String?
    let type, url, viewType: String?
    let winning: Int?

    enum CodingKeys: String, CodingKey {
        case active
        case gameDescription
        case id, image, name, type, url, viewType, winning
    }
}
