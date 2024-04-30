//
//  SelectTransactionTypeViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 01/07/22.
//

import Foundation

enum TransactionType {
    case amazonCard
    case money
}

class SelectTransactionTypeViewModel: BaseViewModel {
    
    var transactionType: TransactionType = .money
    
    var walletDetails: UserWalletResponse
    let completion: (Bool)-> Void
    init(walletDetails: UserWalletResponse,
         completion: @escaping (Bool)-> Void) {
        self.completion = completion
        self.walletDetails = walletDetails
        super.init()
    }
    
    func tapOnItem(transactionType: TransactionType) {
        self.transactionType = transactionType
        self.viewHandler?.showWithdrawAmountScreen(walletDetails: self.walletDetails,
                                                   transactionType: self.transactionType,
                                                   completion: completion)
    }
    
    func backButtonTapped() {
        self.viewHandler?.popViewController()
    }
}
