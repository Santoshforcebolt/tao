//
//  TaoGradientButton.swift
//  tao
//
//  Created by Betto Akkara on 14/02/22.
//

import Foundation
import UIKit
@IBDesignable
public class TaoGradientButton: UIButton {

    @IBInspectable
    public var gradientColor = [UIColor.systemYellow.cgColor, UIColor.systemPink.cgColor]{
        didSet{
            self.layoutSubviews()
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    private lazy var gradientLayer: CAGradientLayer = {
        let l = CAGradientLayer()
        l.frame = self.bounds
        l.colors = gradientColor
        l.startPoint = CGPoint(x: 0, y: 0.5)
        l.endPoint = CGPoint(x: 1, y: 0.5)
        layer.insertSublayer(l, at: 0)
        return l
    }()
}
