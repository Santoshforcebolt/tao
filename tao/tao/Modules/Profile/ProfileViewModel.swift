//
//  ProfileViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 18/06/22.
//

import Foundation

class ProfileViewModel: BaseViewModel {
    var switchTab: (Int)-> Void
    
    init(switchTab: @escaping (Int)-> Void) {
        self.switchTab = switchTab
        super.init()
    }
    
    var profileUpdatable: Bool {
        return TaoHelper.configDetails?.profileUpdatable ?? false
     }

    var userVerified: Bool {
        return TaoHelper.userProfile?.userDetails?.isVerified ?? false
     }
    
    func verifyAccountTapped() {
        self.viewHandler?.showVerifyKyc()
    }
    
    func manageAddressTapped() {
        self.viewHandler?.showManageAddress()
    }
    
    func myWalletTapped() {
        self.viewHandler?.showWallet(switchTab: { index in
            self.viewHandler?.popViewController()
            self.switchTab(index)
        })
    }
    
    func pastTransactionTapped() {
        self.viewHandler?.showTransactionHistory()
    }
    
    func orderOptionTapped() {
        self.viewHandler?.showOrders()
    }
    
    func premiumImageTapped() {
        self.viewHandler?.showManageSubscription()
    }
    
    func faqOptionTapped() {
        if let url = URL(string: "https://tao.live/faq") {
            self.viewHandler?.showWebView(url: url)
        }
    }
    
    func tncOptionTapped() {
        if let url = URL(string: "https://tao.live/terms-and-condition") {
            self.viewHandler?.showWebView(url: url)
        }
    }
    
    func privacyPolicyTapped() {
        if let url = URL(string: "https://tao.live/privacy-policy") {
            self.viewHandler?.showWebView(url: url)
        }
    }
    
    func feedbackOptionTapped() {
        self.viewHandler?.showFeedbackForm()
    }
    
    func supportOptionTapped() {
        self.viewHandler?.showSupportScreen()
    }
    
    func showReferralScreen() {
        self.viewHandler?.showReferralScreen()
    }
    
    func showMyCompetitions() {
        self.viewHandler?.showMyCompetitions()
    }
    
    func showMyVideos() {
        self.viewHandler?.showUserEntriesScreen()
    }
    
    func showMyCertificates() {
        self.viewHandler?.showMyCertificates()
    }
    
    func logout() {
        self.viewHandler?.logout()
    }
}
