//
//  TaoStoryViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 08/06/22.
//

import Foundation

class TaoStoryViewModel: BaseViewModel {
    
    var mediaEntries: [TVMedia]
    var selectedItemIndex: Int
    
    init(mediaEntries: [TVMedia], itemSelected index: Int) {
        self.mediaEntries = mediaEntries
        self.selectedItemIndex = index
        super.init()
    }
}
