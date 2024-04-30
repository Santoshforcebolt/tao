//
//  SearchViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 06/06/22.
//

import Foundation

enum SearchFlow {
    case user
    case product
}

class SearchViewModel: BaseViewModel {
    
    private var products: [Product]?
    private var userInfo: [UserShortInfo]?
    private var workItem: DispatchWorkItem?
    var searchFlow: SearchFlow
    
    init(searchFlow: SearchFlow) {
        self.searchFlow = searchFlow
        super.init()
    }
    
    var numberOfItems: Int {
        return self.products?.count ?? 0
    }
    
    var numberOfUsers: Int {
        self.userInfo?.count ?? 0
    }
    
    func getUser(index: Int) -> UserShortInfo? {
        return self.userInfo?[index]
    }
    
    func getItem(index: Int) -> Product? {
        return self.products?[index]
    }
    
    private func getSearchResults(string: String) {
        self.viewHandler?.showLoading()
        switch self.searchFlow {
        case .user:
            self.apiProvider.tvApi.getSearchResults(query: string) { userSearchInfo, error in
                self.viewHandler?.stopLoading()
                if error != nil {
                    self.handleError(error: error)
                } else {
                    self.userInfo = userSearchInfo?.results
                    self.viewHandler?.reloadView()
                }
            }
        case .product:
            self.apiProvider.storeApi.getSearchResults(query: string) { products, error in
                self.viewHandler?.stopLoading()
                if error != nil {
                    self.handleError(error: error)
                } else {
                    self.products = products?.products
                    self.viewHandler?.reloadView()
                }
            }
        }
    }
    
    func performSearch(query: String) {
        if query.count >= 3 {
            self.workItem?.cancel()
            let newWorkItem = DispatchWorkItem {
                self.getSearchResults(string: query)
            }
            workItem = newWorkItem
            DispatchQueue.global().asyncAfter(deadline: .now() + .milliseconds(200), execute: newWorkItem)
        } else {
            self.workItem?.cancel()
        }
    }
    
    func closeButtonTapped() {
        self.viewHandler?.popViewController()
    }
    
    func itemSelected(at index: Int) {
        if let product = self.products?[index] {
            self.viewHandler?.showProductScreen(product: product)
        } else if let user = self.getUser(index: index) {
            self.viewHandler?.showVisitProfile(userId: user.id ?? "")
        }
    }
}
