//
//  BannerCollectionViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 01/09/22.
//

import Foundation

class BannerCollectionViewModel: BaseViewModel {
    var widgets: [Banner]
    
    init(widgets: [Banner]) {
        self.widgets = widgets
        super.init()
    }
    
    func itemClicked(index: Int) {
        if let linkType = self.widgets[index].linkType,
           linkType == "DEEPLINK" {
            if let name = self.widgets[index].name,
               name == "REFERRAL_SCREEN" {
                self.viewHandler?.showReferralScreen()
            } else if let name = self.widgets[index].name,
                      name == "KYC_SCREEN" {
                self.viewHandler?.showVerifyKyc()
            } else if let name = self.widgets[index].name,
                      name == "SUBSCRIPTION_SCREEN" {
                self.viewHandler?.showManageSubscription()
            }
        } else if let urlString = self.widgets[index].link,
                  let url = URL(string: urlString) {
            self.viewHandler?.showWebView(url: url)
        }
    }
}
