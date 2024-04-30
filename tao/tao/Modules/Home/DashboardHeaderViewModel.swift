//
//  DashboardHeaderViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 01/09/22.
//

import Foundation

class DashboardHeaderViewModel: BaseViewModel {

    var header: String
    var completition: ()-> Void
    
    init(header: String, completition: @escaping ()-> Void) {
        self.header = header
        self.completition = completition
        super.init()
    }
    
    func viewAllTapped() {
        self.completition()
    }
}
