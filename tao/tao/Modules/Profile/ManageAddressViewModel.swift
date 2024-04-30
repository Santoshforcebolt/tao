//
//  ManageAddressViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 26/06/22.
//

import Foundation

class ManageAddressViewModel: BaseViewModel {
    private var addresses: [Address]?
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.getAddresses()
    }
    
    var numberOfAddresses: Int {
        return self.addresses?.count ?? 0
    }
    
    func getAddress(at index: Int) -> Address? {
        return self.addresses?[index]
    }
    
    func addNewAddressTapped() {
        self.viewHandler?.showAddAddressScreen()
    }
    
    func editAddress(address: Address) {
        self.viewHandler?.showAddAddressScreen(action: .edit(address))
    }
    
    func deleteAddress(address: Address) {
        self.viewHandler?.showLoading()
        self.apiProvider.profileApi.deleteAddress(addressId: address.id ?? "") { successString, error in
            self.viewHandler?.stopLoading()
            if error != nil {
                self.handleError(error: error)
            } else {
                self.getAddresses()
            }
        }
    }
    
    func backButtonTapped() {
        self.viewHandler?.popViewController()
    }
    
    func getAddresses() {
        self.viewHandler?.showLoading()
        self.apiProvider.storeApi.getUserAddresses { addresses, error in
            self.viewHandler?.stopLoading()
            if error != nil {
                self.handleError(error: error)
            } else {
                self.addresses = addresses
                self.viewHandler?.reloadView()
            }
        }
    }
}
