//
//  TypeData.swift
//  tao
//
//  Created by Mayank Khursija on 29/06/22.
//

import Foundation

class ImagesData {
    
    static let premiumImage = "https://d3eodi67qi2po9.cloudfront.net/tao/general/4b3e043f69c545688de3a89943cffd7c.webp"
    
    static let dictionary: [String: ImageData] = [
        "DEFAULT": ImageData(name: "Transaction",
                             imageUrl: "https://d3eodi67qi2po9.cloudfront.net/tao/general/c9a5f9d69fa74bc7ab226225f61b002c.webp"),
        "COMPETITION_ACADEMIC": ImageData(name: "Competition reward",
                                          imageUrl: "https://d3eodi67qi2po9.cloudfront.net/tao/general/2994c862e663414a88d91d11f7ed7af5.webp"),
        "COMPETITION_CULTURAL": ImageData(name: "Competition reward",
                                          imageUrl: "https://d3eodi67qi2po9.cloudfront.net/tao/general/2994c862e663414a88d91d11f7ed7af5.webp"),
        "ACTIVITY_ACADEMIC": ImageData(name: "Activity reward",
                                       imageUrl: "https://d3eodi67qi2po9.cloudfront.net/tao/general/2994c862e663414a88d91d11f7ed7af5.webp"),
        "ACTIVITY_CULTURAL": ImageData(name: "Activity reward",
                                       imageUrl: "https://d3eodi67qi2po9.cloudfront.net/tao/general/2994c862e663414a88d91d11f7ed7af5.webp"),
        "COMPETITION_ESPORTS": ImageData(name: "Esports reward",
                                         imageUrl: "https://d3eodi67qi2po9.cloudfront.net/tao/general/2994c862e663414a88d91d11f7ed7af5.webp"),
        "LEADERBOARD_WEEK": ImageData(name: "Weekly Leaderboard reward",
                                      imageUrl: "https://d3eodi67qi2po9.cloudfront.net/tao/general/2994c862e663414a88d91d11f7ed7af5.webp"),
        "LEADERBOARD_MONTH": ImageData(name: "Monthly Leaderboard reward",
                                       imageUrl: "https://d3eodi67qi2po9.cloudfront.net/tao/general/2994c862e663414a88d91d11f7ed7af5.webp"),
        "GAMES_WEB": ImageData(name: "Game reward",
                               imageUrl: "https://d3eodi67qi2po9.cloudfront.net/tao/general/ef1704432cb343ab8f0e61656ba54b3b.webp"),
        "GAMES_APP": ImageData(name: "Game reward",
                               imageUrl: "https://d3eodi67qi2po9.cloudfront.net/tao/general/ef1704432cb343ab8f0e61656ba54b3b.webp"),
        "POLL": ImageData(name: "Poll reward",
                          imageUrl: "https://d3eodi67qi2po9.cloudfront.net/tao/general/98f5c33a279b44ee910c8de8d7a7e218.webp"),
        "BONUS": ImageData(name: "Bonus reward",
                           imageUrl: "https://d3eodi67qi2po9.cloudfront.net/tao/general/549df48d432643b0a11ab5b9718a59db.webp"),
        "SUBSCRIPTION": ImageData(name: "Subscription reward",
                                  imageUrl: "https://d3eodi67qi2po9.cloudfront.net/tao/general/c9a5f9d69fa74bc7ab226225f61b002c.webp"),
        "PAYOUT": ImageData(name: "Reward",
                            imageUrl: "https://d3eodi67qi2po9.cloudfront.net/tao/general/c9a5f9d69fa74bc7ab226225f61b002c.webp"),
        "STORE_ORDER": ImageData(name: "Reward",
                                 imageUrl: "https://d3eodi67qi2po9.cloudfront.net/tao/general/9b73819b81c04c9492e5852f7d879d20.webp")
    ]
    
    struct ImageData {
        var name: String
        var imageUrl: String
    }
}
