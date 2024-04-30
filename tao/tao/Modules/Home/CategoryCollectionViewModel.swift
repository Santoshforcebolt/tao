//
//  CategoryCollectionViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 06/09/22.
//

import Foundation

class CategoryCollectionViewModel: BaseViewModel {
    var categories: [CategoryDetails]
    
    init(categories: [CategoryDetails]) {
        self.categories = categories
        super.init()
    }
    
    func didSelectItem(at index: Int) {
        self.viewHandler?.showAllCompsByCategory(cateogry: categories[index].category ?? "",
                                                 subCategory: categories[index].subCategory ?? "")
    }
}
