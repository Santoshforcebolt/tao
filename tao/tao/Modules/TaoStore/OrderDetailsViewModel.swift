//
//  OrderDetailsViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 05/06/22.
//

import Foundation

enum OrderFlow {
    case store
    case myOrders
}

class OrderDetailsViewModel: BaseViewModel {
    var product: Product
    var orderStatus: OrderStatus
    var order: Order
    var flow: OrderFlow
    
    init(product: Product, order: Order, orderStatus: OrderStatus, flow: OrderFlow = .store) {
        self.product = product
        self.orderStatus = orderStatus
        self.order = order
        self.flow = flow
        super.init()
    }
    
    var message: String {
        switch self.orderStatus {
        case .PLACED:
            return "Wohooo! Your reward is on its way!"
        case .DISPATCHED:
            return "Your order has been dispatched"
        case .IN_TRANSIT:
            return "Your order is on the way"
        case .DELIVERED:
            return "Yay !! You have received the order"
        case .CANCELLED:
            return "We are sorry you had to cancel the order"
        }
    }
    
    var isOrderDigital: Bool {
        return self.order.orderData?.digital ?? false
    }
    
    func cancelButtonTapped() {
        self.apiProvider.storeApi.cancelOrder(orderId: self.order.orderData?.id ?? "") { _, error in
            if error != nil {
                self.handleError(error: error)
            } else {
                self.viewHandler?.showToast(with: "Order cancelled")
                switch self.flow {
                case .store:
                    self.viewHandler?.popToViewController(ofClass: ParentViewController.self)
                case .myOrders:
                    self.viewHandler?.popViewController()
                }
            }
        }
    }
    
    func exitButtonTapped() {
        switch self.flow {
        case .store:
            self.viewHandler?.popToViewController(ofClass: ParentViewController.self)
        case .myOrders:
            self.viewHandler?.popViewController()
        }

    }
    
    func backButtonTapped() {
        switch self.flow {
        case .store:
            self.viewHandler?.popToViewController(ofClass: ParentViewController.self)
        case .myOrders:
            self.viewHandler?.popViewController()
        }
    }
    
    func downloadButtonTapped() {
        if let downloadLink = self.order.orderData?.downloadLink {
            self.viewHandler?.showLoading()
            self.apiProvider.storeApi.downloadImage(url: downloadLink) { data, error in
                self.viewHandler?.stopLoading()
                if error != nil {
                    self.handleError(error: error)
                } else {
                    if let data = data,
                       let image = UIImage(data: data) {
                        UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
                    }
                }
            }
        }
    }
    
    //MARK: - Save Image callback

    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            self.viewHandler?.showToast(with: error.localizedDescription)

        } else {
            self.viewHandler?.showToast(with: "Image Downloaded")
        }
    }
}
