//
//  Store.swift
//  tao
//
//  Created by Mayank Khursija on 06/06/22.
//

import Foundation

struct Store: Codable {
    var productCategoryList: [ProductCategory]?
    var widgets: [Widget]?
}

struct ProductCategory: Codable {
    var bgColor: String?
    var code: String?
    var id: String?
    var imageUrl: String?
    var name: String?
}

struct Widget: Codable {
    var active: Bool?
    var audienceIds: [Int]?
    var background: String?
    var cta: String?
    var id: String?
    var imageUrl: String?
    var link: String?
    var linkType: String?
    var maxAppVersion: Double?
    var minAppVersion: Double?
    var name: String?
    var priority: Double?
    var screenType: String?
    var subText: String?
    var subType: String?
    var text: String?
    var type: String?
}

struct SearchProducts: Codable {
    var products: [Product]?
}

struct Product: Codable {
    var brand: String?
    var cashAmount: Double?
    var cashDiscount: Double?
    var category: String?
    var coinsAmount: Double?
    var coinsDiscount: Double?
    var currency: String?
    var description: String?
    var id: String?
    var image: String?
    var imageUrls: [String]?
    var isDeleted: Bool?
    var name: String?
    var searchName: String?
    var tags: [String]?
    var trending: Bool?
    var type: String?
}

struct Address: Codable {
    var country: String?
    var district: String?
    var house: String?
    var id: String?
    var phone: String?
    var pin: Int?
    var state: String?
    var street: String?
    
    func fullAddress() -> String {
        return "\(self.house ?? ""), \(self.street ?? "")\n\(self.district ?? ""), \(self.state ?? ""), \(self.pin ?? 0)\n\(self.country ?? "")\nPhone Number: \(self.phone ?? "")"
    }
}

struct Order: Codable {
    var productData: Product?
    var orderData: OrderData?
}

struct OrderData: Codable {
    var amount: Double?
    var billingAddress: String?
    var category: String?
    var currency: String?
    var deliveryAddress: String?
    var deliveryFee: Double?
    var id: String?
    var isDeliveryFree: Bool?
    var productDescription: String?
    var productId: String?
    var productImage: String?
    var productName: String?
    var status: String?
    var tax: Double?
    var userId: String?
    var digital: Bool?
    var downloadLink: String?
}

struct OrderList: Codable {
    var orderList: [OrderData]?
}

struct ProductData: Codable {
    var cursor: String?
    var productList: [Product]?
}
