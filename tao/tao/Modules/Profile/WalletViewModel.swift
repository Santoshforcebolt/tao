//
//  WalletViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 27/06/22.
//

import Foundation

class WalletViewModel: BaseViewModel {
    
    var walletBanners: WalletBanners?
    var walletResponse: UserWalletResponse?
    var switchTab: ((Int)-> Void)?
    
    init(switchTab: ((Int)-> Void)?) {
        self.switchTab = switchTab
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getWalletDetails()
    }
    
    func moneyCardTapped() {
        if let walletResponse = self.walletResponse {
            self.viewHandler?.showSelectTransactionType(walletDetails: walletResponse, completion: { success in
                if success {
                    self.viewHandler?.showToast(with: "Transaction Success")
                    self.getWalletDetails()
                } else {
                    self.viewHandler?.showToast(with: "Some error occured. Please try again!")
                }
            })
        }
    }
    
    private func getWalletDetails() {
        self.viewHandler?.showLoading()
        self.apiProvider.profileApi.getWalletBanners { walletBanners, error in
            self.viewHandler?.stopLoading()
            if error != nil {
                self.handleError(error: error)
            } else {
                self.walletBanners = walletBanners
                self.viewHandler?.showLoading()
                self.apiProvider.profileApi.getWalletDetails { walletResponse, error in
                    self.viewHandler?.stopLoading()
                    if error != nil {
                        self.handleError(error: error)
                    } else {
                        self.walletResponse = walletResponse
                        self.viewHandler?.reloadView()
                    }
                }
            }
        }
    }
    
    func backButtonTapped() {
        self.viewHandler?.popViewController()
    }
    
    func showHistory() {
        self.viewHandler?.showTransactionHistory()
    }
    
    func coinCardTapped() {
        self.switchTab?(Tabs.store.rawValue)
    }
}
