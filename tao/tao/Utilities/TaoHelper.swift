//
//  TaoHelper.swift
//  tao
//
//  Created by Betto Akkara
//

import Foundation

//MARK: Remove TaoHelper
struct TaoHelper {
    // MARK: - Global functions
    static func delay(_ delay: Double, block: @escaping () -> (Void)) {
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.asyncAfter(deadline: (DispatchTime.now() + delay), execute: block)
        }
    }

    static var configDetails : GetAppConfig?
    static var homeDetails : HomeDetails?
    static var competitionCategories : [CategoryDetails]?
    static var userProfile: UserProfile?
    
    static var competitionId : String?
    static var userID : String?
    
    
    static func openExternal(urlString: String) {
        
        if let url = URL(string: urlString) {
           
            if UIApplication.shared.canOpenURL(url) {
               
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        
    }
    
    struct constants {

        let bannerView_height : CGFloat = 150
        
        let categoryView_width : CGFloat = 80
        let categoryView_height : CGFloat = 80
        
        let extraCarricularsView_width : CGFloat = 200
        let extraCarricularsView_height : CGFloat = 280
        let academicCompetition_width : CGFloat = 200
        let academicCompetition_height : CGFloat = 240
        
        let eventView_width : CGFloat = TaoHelper.constants.itemWidth(for: UIScreen.main.bounds.width - 40, spacing: 5)
        let eventView_height : CGFloat = TaoHelper.constants.itemWidth(for: UIScreen.main.bounds.width - 40, spacing: 5) + (TaoHelper.constants.itemWidth(for: UIScreen.main.bounds.width - 40, spacing: 5) * 0.2)

        let trendingView_width : CGFloat = 80
        let trendingView_height : CGFloat = 120


        let specialCompetitionView_height : CGFloat = 230
        
        static func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
            let itemsInRow: CGFloat = 2

            let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
            let finalWidth = (width - totalSpacing) / itemsInRow

            return finalWidth - 5.0
        }


    }

}
