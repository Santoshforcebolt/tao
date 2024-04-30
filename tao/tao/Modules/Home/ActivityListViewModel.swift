//
//  ActivityListViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 01/09/22.
//

import Foundation

class ActivityListViewModel: BaseViewModel {
    var competitions: [Activity]
    
    init(competitions: [Activity]) {
        self.competitions = competitions
        super.init()
    }
    
    func backButtonTapped() {
        self.viewHandler?.popViewController()
    }
}
