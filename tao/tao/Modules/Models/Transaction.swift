//
//  Transaction.swift
//  tao
//
//  Created by Mayank Khursija on 29/06/22.
//

import Foundation

struct Transactions: Codable {
    var transactions: [Transaction]?
}

struct Transaction: Codable {
    var amount: Float?
    var cashBalance: Float?
    var category: String?
    var coinBalance: Float?
    var currency: String?
    var description: String?
    var subCategory: String?
    var subType: String?
    var type: String?
    var createdOn: String?
}
