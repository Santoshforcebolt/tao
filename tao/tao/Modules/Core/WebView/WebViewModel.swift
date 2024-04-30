//
//  WebViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 11/08/22.
//

import Foundation

class WebViewModel: BaseViewModel {
    
    var request: URLRequest
    init(url: URL) {
        self.request = URLRequest(url: url)
        super.init()
    }
    
    func backButtonTapped() {
        self.viewHandler?.popViewController()
    }
    
    func isLoading(_ isLoading: Bool) {
        if isLoading {
            self.viewHandler?.showLoading()
        } else {
            self.viewHandler?.stopLoading()
        }
    }
}
