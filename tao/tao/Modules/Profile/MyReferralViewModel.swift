//
//  MyReferralViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 14/08/22.
//

import Foundation

class MyReferralViewModel: BaseViewModel {
    
    var referrals: Referrals?
    var cursor: String?
    var referralsData: ReferralsData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewHandler?.showLoading()
        self.apiProvider.profileApi.getUserReferralsData { referralsData, error in
            self.viewHandler?.stopLoading()
            if error != nil {
                self.handleError(error: error)
            } else {
                self.referralsData = referralsData
                self.viewHandler?.showLoading()
                self.apiProvider.profileApi.getUserReferrals(cursor: self.cursor) { referrals, error in
                    self.viewHandler?.stopLoading()
                    if error != nil {
                        self.handleError(error: error)
                    } else {
                        self.referrals = referrals
                        self.cursor = referrals?.cursor
                        self.viewHandler?.reloadView()
                    }
                }
            }
        }
    }
    
    func loadMoreEntries() {
        if let cursor = cursor {
            self.viewHandler?.showLoading()
            self.apiProvider.profileApi.getUserReferrals(cursor: cursor) { referrals, error in
                self.viewHandler?.stopLoading()
                if error != nil {
                    self.handleError(error: error)
                } else {
                    self.referrals?.referrals?.append(contentsOf: referrals?.referrals ?? [])
                    self.cursor = referrals?.cursor
                    self.viewHandler?.reloadView()
                }
            }

        }
    }
    
    func backButtonTapped() {
        self.viewHandler?.popViewController()
    }
    
    func referralButtonTapped() {
        self.viewHandler?.showToast(with: "Copied to clipboard")
    }
    
    func shareOnWhatsappTapped() {
        let urlWhats = "whatsapp://send?phone=+918095563666&abid=12354&text=Download the app now \(self.referralsData?.shareLink ?? "")"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL) {
                    UIApplication.shared.open(whatsappURL,
                                              options: [:],
                                              completionHandler: nil)
                } else {
                    print("Install Whatsapp")
                }
            }
        }
    }
}
