//
//  InstructionViewModel.swift
//  tao
//
//  Created by Mayank Khursija on 29/05/22.
//

import Foundation

enum TextType {
    case plain(String)
    case clock(Date)
}

enum Image {
    case withURL(URL)
    case withImage(UIImage)
}

class InstructionViewModel {
    
    var text: TextType
    var image: Image
    
    init(text: TextType, image: Image) {
        self.text = text
        self.image = image
    }
    
}
