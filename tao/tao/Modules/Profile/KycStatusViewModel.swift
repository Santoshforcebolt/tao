//
//  KycStatusViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 11/08/22.
//

import Foundation

enum KycStatuses: String {
    case PENDING
    case REJECTED
    case APPROVED
}

class KycStatusViewModel: BaseViewModel {
    var status: KycStatuses
    
    init(status: KycStatuses) {
        self.status = status
        super.init()
    }
    
    func backButtonTapped() {
        self.viewHandler?.popToViewController(ofClass: ParentViewController.self)
    }
}
