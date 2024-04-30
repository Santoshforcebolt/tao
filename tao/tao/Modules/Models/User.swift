//
//  User.swift
//  tao
//
//  Created by Mayank Khursija on 15/06/22.
//

import Foundation

struct UserSearchInfo: Codable {
    var results: [UserShortInfo]?
}

struct UserShortInfo: Codable {
    var id: String?
    var imageUrl: String?
    var subTitle: String?
    var title: String?
    var type: String?
}
