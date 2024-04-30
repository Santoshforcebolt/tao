//
//  searchLocationModel.swift
//  tao
//
//  Created by Betto Akkara on 07/03/22.
//

import Foundation

// MARK: - SearchLocationElement
struct SearchLocationElement: Codable {
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

typealias SearchLocation = [SearchLocationElement]
