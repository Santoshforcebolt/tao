//
//  Wallet.swift
//  tao
//
//  Created by Mayank Khursija on 27/06/22.
//

import Foundation

struct WalletBanners: Codable {
    var topBanners: [WalletBanner]?
}

struct WalletBanner: Codable {
    var imageUrl: String?
    var link: String?
}

struct FundAccount: Codable {
    var contact_id: String?
    var id: String?
}

struct Payout: Codable {
    var status: String?
}
