//
//  StoreApi.swift
//  tao
//
//  Created by Mayank Khursija on 06/06/22.
//

import Foundation
import Alamofire

//FIXME: Seggregate Properly
protocol StoreApi {
    func getAllProductCategories(completion: @escaping (Store?, AFError?) -> Void)
    func getTrendingProducts(completion: @escaping ([Product]?, AFError?) -> Void)
    func getSearchResults(query: String, completion: @escaping (SearchProducts?, AFError?) -> Void)
    func getUserAddresses(completion: @escaping ([Address]?, AFError?) -> Void)
    func createAddress(address: Address, completion: @escaping (Address?, AFError?) -> Void)
    func createOrder(product: Product, address: Address?, completion: @escaping (Order?, AFError?) -> Void)
    func cancelOrder(orderId: String, completion: @escaping (EmptyResponse?, AFError?)->Void)
    func getProductsByCategory(cursor: String?, category: String, completion: @escaping (ProductData?, AFError?)-> Void)
    func downloadImage(url: String, completion: @escaping (Data?, AFError?)->Void)
}

class StoreApiImpl: Api, StoreApi {
    
    let allProductsUrl = "\(AppController.shared.getBaseURL())api/v2/store/category/get/all"
    
    let trendingProductsUrl = "\(AppController.shared.getBaseURL())api/v1/store/trending"
    
    let searchUrl = "\(AppController.shared.getBaseURL())api/v1/search/product"
    
    let addressUrl = "\(AppController.shared.getBaseURL())api/v1/address/user/%@"
    
    let createAddressUrl = "\(AppController.shared.getBaseURL())api/v1/address/create"
    
    let createOrderUrl = "\(AppController.shared.getBaseURL())api/v1/store/createOrder"
    
    let cancelOrderUrl = "\(AppController.shared.getBaseURL())api/v1/store/order/cancel/%@"
    
    let getProductsByCategoryURL = "\(AppController.shared.getBaseURL())api/v1/store/getProductList"
    
    func getAllProductCategories(completion: @escaping (Store?, AFError?) -> Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: self.allProductsUrl,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completion)
    }
    
    func getTrendingProducts(completion: @escaping ([Product]?, AFError?) -> Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: self.trendingProductsUrl,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completion)
    }
    
    func getSearchResults(query: String, completion: @escaping (SearchProducts?, AFError?) -> Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: self.searchUrl,
                                    method: .post,
                                    parameters: ["text": query],
                                    headers: headers,
                                    encoding: JSONEncoding.default,
                                    completion: completion)
    }
    
    func getUserAddresses(completion: @escaping ([Address]?, AFError?) -> Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        let url = String(format: self.addressUrl, headers.value(for: "userid") ?? "")
        self.networkManager.request(urlString: url,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completion)
    }
    
    func createAddress(address: Address, completion: @escaping (Address?, AFError?) -> Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        self.networkManager.request(urlString: self.createAddressUrl,
                                    method: .post,
                                    parameters: ["country": address.country ?? "",
                                                 "district": address.district ?? "",
                                                 "house": address.house ?? "",
                                                 "phone": address.phone ?? "",
                                                 "pin": address.pin ?? "",
                                                 "state": address.state ?? "",
                                                 "street": address.street ?? "",
                                                 "userId": TaoHelper.userID ?? ""],
                                    headers: headers,
                                    encoding: JSONEncoding.default,
                                    completion: completion)
    }
    
    func createOrder(product: Product, address: Address?, completion: @escaping (Order?, AFError?) -> Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        if let address = address {
            self.networkManager.request(urlString: self.createOrderUrl,
                                        method: .post,
                                        parameters: ["storeOrder": ["amount": 0,
                                                                   "deliveryFee": 0,
                                                                   "isDeliveryFree": true,
                                                                   "status": "PLACED",
                                                                   "tax": 0,
                                                                   "billingAddress": address.fullAddress(),
                                                                   "deliveryAddress": address.fullAddress(),
                                                                    "productId": product.id ?? "",
                                                                   "userId": TaoHelper.userID ?? ""]],
                                        headers: headers,
                                        encoding: JSONEncoding.default,
                                        completion: completion)
        }
    }
    
    func cancelOrder(orderId: String, completion: @escaping (EmptyResponse?, AFError?)->Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        let url = String(format: self.cancelOrderUrl, orderId)

        self.networkManager.request(urlString: url,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completion)
    }
    
    func getProductsByCategory(cursor: String?, category: String, completion: @escaping (ProductData?, AFError?)-> Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        let params: [String:Any]
        if let cursor = cursor {
            params = ["category":category, "cursor": cursor]
        } else {
            params = ["category":category]
        }
        
        self.networkManager.request(urlString: self.getProductsByCategoryURL,
                                    method: .post,
                                    parameters: params,
                                    headers: headers,
                                    encoding: JSONEncoding.default,
                                    completion: completion)
    }
    
    func downloadImage(url: String, completion: @escaping (Data?, AFError?)->Void) {
        self.networkManager.download(url: url, completion: completion)
    }
}
