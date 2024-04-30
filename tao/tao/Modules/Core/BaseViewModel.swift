//
//  BaseViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 28/05/22.
//

import Foundation
import Alamofire

protocol ViewModel {
    var apiProvider: ApiProvider { get set }
    var permissionManager: PermissionManager { get set }
}

class BaseViewModel: ViewModel, ViewTransitionEvents {
    var apiProvider: ApiProvider
    var permissionManager: PermissionManager

    var viewHandler: BaseViewHandler?
    var depricatedApiProvider: APIDataProvider
    
    init(apiDataProvider: ApiProvider = ApiProviderImpl.instance,
         permissionManager: PermissionManager = PermissionManager(),
         depricatedApiProvider: APIDataProvider = APIDataProvider.init()) {
        self.apiProvider = apiDataProvider
        self.permissionManager = permissionManager
        self.depricatedApiProvider = depricatedApiProvider
    }
    
    func viewDidLoad() {
        //To be implemented by child
    }
    
    func viewWillAppear() {
        //To be implemented by child
    }
    
    func viewDidAppear() {
        //To be implemented by child
    }
    
    func viewWillDisappear() {
        //To be implemented by child
    }
    
    func viewDidDisappear() {
        //To be implemented by child
    }
    
    func handleError(error: AFError?) {
        if error?.responseCode == 401 {
            self.viewHandler?.logout()
        } else {
            self.viewHandler?.showToast(with: "Something went wrong! Please try again!")
        }
    }
}
