//
//  OrdersViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 28/06/22.
//

import Foundation

class OrdersViewModel: BaseViewModel {
    
    var orderList: [OrderData]?
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.viewHandler?.showLoading()
        self.apiProvider.profileApi.getOrderList { orderList, error in
            self.viewHandler?.stopLoading()
            if error != nil {
                self.handleError(error: error)
            } else {
                self.orderList = orderList?.orderList
                self.viewHandler?.reloadView()
            }
        }
    }
    
    func getStatusString(for index: Int) -> (UIColor, String) {
        if let order = self.orderList?[index] {
            if order.status == "DELIVERED" {
                return (UIColor.systemGreen, "Order delievered")
            } else if order.status == "CANCELLED" {
                return (UIColor.systemRed, "Your order has been cancelled")
            } else {
                return (UIColor.systemOrange, "Your order is on the way")
            }
        }
        return (UIColor.systemOrange, "")
    }
    
    func itemSelected(index: Int) {
        if let orderData = orderList?[index] {
            let product = Product(brand: nil, cashAmount: orderData.amount, cashDiscount: nil, category: orderData.category, coinsAmount: orderData.amount, coinsDiscount: nil, currency: orderData.currency, description: orderData.productDescription, id: orderData.productId, image: orderData.productImage, imageUrls: nil, isDeleted: nil, name: orderData.productName, searchName: orderData.productName, tags: nil, trending: nil, type: nil)
            let order = Order(productData: product, orderData: orderData)
            let orderStatus = OrderStatus(rawValue: orderData.status ?? "") ?? .IN_TRANSIT
            self.viewHandler?.showOrderSuccessScreen(product: product, order: order, orderStatus: orderStatus, flow: .myOrders)
        }
    }
    
    func backButtonTapped() {
        self.viewHandler?.popViewController()
    }
}
