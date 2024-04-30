//
//  ProductDetailViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 04/06/22.
//

import Foundation

class ProductDetailViewModel: BaseViewModel {
    
    var product: Product
    
    init(product: Product) {
        self.product = product
        super.init()
    }
    
    var imageUrls: [String] {
        return product.imageUrls ?? []
    }
    
    var productTitle: String {
        return self.product.name ?? ""
    }
    
    var discountedPrice: String {
        return String(self.product.coinsDiscount ?? 0)
    }
    
    var price: String {
        return String(self.product.coinsAmount ?? 0)
    }
    
    var numberOfImages: Int {
        return self.product.imageUrls?.count ?? 0
    }
    
    func backButtonTapped() {
        self.viewHandler?.popViewController()
    }
    
    func claimNowButtonTapped() {
        self.viewHandler?.showOrderDetailsScreen(product: self.product)
    }
}
