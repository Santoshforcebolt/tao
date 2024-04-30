//
//  TrendingCellViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 06/06/22.
//

import Foundation

class TrendingCellViewModel: BaseViewModel {
    
    var product: Product
    
    init(product: Product) {
        self.product = product
        super.init()
    }

}
