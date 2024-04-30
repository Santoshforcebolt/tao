//
//  AddressViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 07/06/22.
//

import Foundation

class AddressViewModel: BaseViewModel {
    
    enum Action {
        case add
        case edit(Address)
    }
    
    var address: Address?
    let action: Action
    
    init(action: Action = .add) {
        self.action = action
        switch action {
        case .add:
            break
        case .edit(let address):
            self.address = address
        }
        super.init()
    }
    
    func addNewAddressTapped(address: Address) {
        switch self.action {
        case .add:
            self.viewHandler?.showLoading()
            self.apiProvider.storeApi.createAddress(address: address) { address, error in
                self.viewHandler?.stopLoading()
                if error != nil {
                    self.handleError(error: error)
                } else {
                    self.viewHandler?.popViewController()
                }
            }
        case .edit(_):
            self.viewHandler?.showLoading()
            self.apiProvider.profileApi.updateAddress(address: address) { emptyResponse, error in
                if error != nil {
                    self.handleError(error: error)
                } else {
                    self.viewHandler?.popViewController()
                }
            }
        }
    }
    
    func backButtonTapped() {
        self.viewHandler?.popViewController()
    }

}
