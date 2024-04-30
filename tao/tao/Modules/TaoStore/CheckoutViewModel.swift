//
//  CheckoutViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 04/06/22.
//

import Foundation

enum OrderStatus: String {
    case PLACED
    case DISPATCHED
    case IN_TRANSIT
    case DELIVERED
    case CANCELLED
}

class CheckoutViewModel: BaseViewModel {
    
    var product: Product
    private var addresses: [Address]?
    
    init(product: Product) {
        self.product = product
        super.init()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
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
    
    var numberOfAddresses: Int {
        return self.addresses?.count ?? 0
    }
    
    func getAddress(at index: Int) -> Address? {
        return self.addresses?[index]
    }
    
    func claimRewardTapped(address: Address?) {
        self.viewHandler?.showLoading()
        self.apiProvider.storeApi.createOrder(product: product, address: address) { order, error in
            self.viewHandler?.stopLoading()
            if error != nil {
                if error?.responseCode == 400 {
                    self.viewHandler?.showToast(with: "Please verify KYC before placing order!!")
                } else {
                    self.handleError(error: error)
                }
            } else if error?.responseCode == 400 {
                self.viewHandler?.showToast(with: "Please verify KYC first!!")
            }
            else {
                if let order = order {
                    let status = OrderStatus(rawValue: order.orderData?.status ?? "")
                    self.viewHandler?.showOrderSuccessScreen(product: self.product, order: order, orderStatus: status ?? .IN_TRANSIT, flow: .store)
                }
            }
        }
    }
    
    func backButtonTapped() {
        self.viewHandler?.popViewController()
    }
    
    func addNewAddressTapped() {
        self.viewHandler?.showAddAddressScreen()
    }
}
