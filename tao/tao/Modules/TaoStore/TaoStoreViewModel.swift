//
//  TaoStoreViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 03/06/22.
//

import Foundation

struct Categories {
    var imageUrl: String?
    var title: String?
}

class TaoStoreViewModel: BaseViewModel {
    private var store: Store?
    private var trendingProducts: [Product]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAllProductCategories()
    }
    
    private func getAllProductCategories() {
        self.viewHandler?.showLoading()
        self.apiProvider.storeApi.getAllProductCategories { store, error in
            self.viewHandler?.stopLoading()
            if error != nil {
                self.handleError(error: error)
            } else {
                self.store = store
                self.viewHandler?.reloadView()
            }
        }
        
        self.apiProvider.storeApi.getTrendingProducts { trendingProducts, error in
            self.viewHandler?.stopLoading()
            if error != nil {
                self.handleError(error: error)
            } else {
                self.trendingProducts = trendingProducts
                self.viewHandler?.reloadView()
            }
        }
    }
    
    var numberOfWidgets: Int {
        return self.store?.widgets?.count ?? 0
    }
    
    var numberOfCategories: Int {
        return self.store?.productCategoryList?.count ?? 0
    }
    
    var numberOfTrendingProducts: Int {
        return self.trendingProducts?.count ?? 0
    }
    
    func searchButtonTapped() {
        self.viewHandler?.showSearchScreen(searchFlow: .product)
    }
    
    func getWidget(index: Int) -> Widget? {
        return self.store?.widgets?[index]
    }
    
    func getCategory(index: Int) -> ProductCategory? {
        return self.store?.productCategoryList?[index]
    }
    
    func getTrendingProduct(index: Int) -> Product? {
        return self.trendingProducts?[index]
    }
    
    func didSelectTrendingItem(at index: Int) {
        if let product = self.trendingProducts?[index] {
            self.viewHandler?.showProductScreen(product: product)
        }
    }
    
    func didSelectCategoryItem(at index: Int) {
        if let category = self.getCategory(index: index) {
            self.viewHandler?.showProductsByCategory(cateogry: category.code ?? "")
        }
    }
    
    func didSelectBannerItem(at index: Int) {
        if let banner = self.getWidget(index: index) {
            if let linkType = banner.linkType,
               linkType == "DEEPLINK" {
                if let name = banner.name,
                   name == "REFERRAL_SCREEN" {
                    self.viewHandler?.showReferralScreen()
                } else if let name = banner.name,
                          name == "KYC_SCREEN" {
                    self.viewHandler?.showVerifyKyc()
                } else if let name = banner.name,
                          name == "SUBSCRIPTION_SCREEN" {
                    self.viewHandler?.showManageSubscription()
                }
            } else if let urlString = banner.link,
                      let url = URL(string: urlString) {
                self.viewHandler?.showWebView(url: url)
            }
        }
    }
    
    func walletTapped() {
        self.viewHandler?.showWallet(switchTab: { index in
            self.viewHandler?.popViewController()
        })
    }
    
    func notificationTapped() {
        self.viewHandler?.showNotifications()
    }
}
