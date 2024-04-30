//
//  Notification.swift
//  tao
//
//  Created by Mayank Khursija on 11/08/22.
//

import Foundation

struct Notifications: Codable {
    let count: Int?
    let notifications: [NotificationData]?
}

// MARK: - Notification
struct NotificationData: Codable {
    let body, deeplink, id, imageURL: String?
    let nfID, screen, time, title: String?

    enum CodingKeys: String, CodingKey {
        case body, deeplink, id
        case imageURL
        case nfID
        case screen, time, title
    }
}
