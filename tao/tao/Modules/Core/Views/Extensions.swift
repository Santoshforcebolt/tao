//
//  UITextField.swift
//  tao
//
//  Created by Mayank Khursija on 07/06/22.
//

import Foundation

extension UITextField {

    func setLeftIcon(_ icon: UIImage, size: CGFloat = 20, padding: CGFloat = 8) {
        
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: size+padding, height: size) )
        let iconView  = UIImageView(frame: CGRect(x: padding, y: 0, width: size, height: size))
        iconView.image = icon
        outerView.addSubview(iconView)
        
        leftView = outerView
        leftViewMode = .always
    }
    
    func setRightIcon(_ icon: UIImage, size: CGFloat = 20, padding: CGFloat = 8) {
        
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: size+padding, height: size) )
        let iconView  = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        iconView.image = icon
        outerView.addSubview(iconView)
        
        rightView = outerView
        rightViewMode = .always
    }
}

extension UILabel {
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }
}
