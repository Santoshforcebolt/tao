//
//  WithdrawRewardViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 28/06/22.
//

import Foundation

class WithdrawRewardViewModel: BaseViewModel {
    
    var walletDetails: UserWalletResponse
    var transactionType: TransactionType
    let completion: (Bool)-> Void
    init(walletDetails: UserWalletResponse,
         transactionType: TransactionType,
         completion: @escaping (Bool)-> Void) {
        self.walletDetails = walletDetails
        self.transactionType = transactionType
        self.completion = completion
        super.init()
    }
    
    func backButtonTapped() {
        self.viewHandler?.popViewController()
    }
    
    func withdrawButtonTapped(vpa: String, amount: Int) {
        //MARK: OPTIMIZATION PENDING
        self.viewHandler?.showLoading()
        self.apiProvider.profileApi.createFundAccount(vpa: vpa,
                                                      amount: amount) { fundAccount, error in
            self.viewHandler?.stopLoading()
            if error != nil {
                self.handleError(error: error)
            } else {
                self.viewHandler?.showLoading()
                self.apiProvider.profileApi.createPayout(vpa: vpa,
                                                         amount: amount,
                                                         accountId: fundAccount?.id ?? "",
                                                         contactId: fundAccount?.contact_id ?? "") { payout, _error in
                    self.viewHandler?.stopLoading()
                    if _error != nil {
                        self.handleError(error: error)
                    } else {
                        if payout?.status == "SUCCESS" {
                            self.completion(true)
                        } else {
                            self.completion(false)
                        }
                    }
                }
            }
        }
    }
}
