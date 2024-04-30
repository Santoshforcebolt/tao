//
//  CategoryProductViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 12/08/22.
//

import Foundation

class CategoryProductViewModel: BaseViewModel {
    
    let category: String
    var cursor: String?
    var products: [Product]?
    
    init(category: String) {
        self.category = category
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewHandler?.showLoading()
        self.apiProvider.storeApi.getProductsByCategory(cursor: self.cursor,
                                                        category: self.category) { productData, error in
            self.viewHandler?.stopLoading()
            if error != nil {
                self.handleError(error: error)
            } else {
                self.products = productData?.productList
                self.cursor = productData?.cursor
                self.viewHandler?.reloadView()
            }
        }
    }
    
    func loadMoreItems() {
        self.viewHandler?.showLoading()
        if let cursor = cursor {
            self.apiProvider.storeApi.getProductsByCategory(cursor: self.cursor,
                                                            category: self.category) { productData, error in
                self.viewHandler?.stopLoading()
                if error != nil {
                    self.handleError(error: error)
                } else {
                    self.products?.append(contentsOf: productData?.productList ?? [])
                    self.cursor = productData?.cursor
                    self.viewHandler?.reloadView()
                }
            }
        }
    }
    
    func didSelectItem(at index: Int) {
        if let product = self.products?[index] {
            self.viewHandler?.showProductScreen(product: product)
        }
    }
    
    func backButtonTapped() {
        self.viewHandler?.popViewController()
    }
}
