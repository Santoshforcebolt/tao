//
//  TransactionHistoryViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 28/06/22.
//

import Foundation

class TransactionHistoryViewModel: BaseViewModel {
    
    enum TransactionType: String {
        case credit = "CREDIT"
        case debit = "DEBIT"
    }
    
    var transactions: [Transaction]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewHandler?.showLoading()
        self.apiProvider.profileApi.getTransactions { transactions, error in
            self.viewHandler?.stopLoading()
            if error != nil {
                self.handleError(error: error)
            } else {
                self.transactions = transactions?.transactions
                self.viewHandler?.reloadView()
            }
        }
    }
    
    func getTransactionType(for index: Int) -> TransactionType {
        if let transaction = self.transactions?[index] {
            let type = TransactionType(rawValue: transaction.type ?? "") ?? .credit
            return type
        }
        return .credit
    }
    
    func isTransactionCoins(for index: Int) -> Bool {
        if let transaction = self.transactions?[index] {
            if transaction.subType == "REWARDS_COIN" {
                return true
            } else {
                return false
            }
        }
        return true
    }
    
    func backButtonTapped() {
        self.viewHandler?.popViewController()
    }
}
