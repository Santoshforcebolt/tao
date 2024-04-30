//
//  UIColor+Additions.swift
//  BACalender
//
//  Created by Betto Akkara on 20/10/20.
//  Copyright © 2020 Betto Akkara. All rights reserved.
//

import UIKit

extension UIColor {

    @nonobjc class var royal: UIColor {
        return UIColor(red: 17.0 / 255.0, green: 39.0 / 255.0, blue: 180.0 / 255.0, alpha: 1.0)
    }
	
	@nonobjc class var darkRoyal: UIColor {
		return UIColor(red: 0.0 / 255.0, green: 16.0 / 255.0, blue: 122.0 / 255.0, alpha: 1.0)
	}
	
    @nonobjc class var appleGreen: UIColor {
        return UIColor(red: 126.0 / 255.0, green: 211.0 / 255.0, blue: 33.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var scarlet: UIColor {
        return UIColor(red: 208.0 / 255.0, green: 2.0 / 255.0, blue: 27.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var lightGray: UIColor {
        return UIColor(red: 199.0 / 255.0, green: 199.0 / 255.0, blue: 199.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var lightOrange: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 150.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var azure: UIColor {
        return UIColor(red: 0.0, green: 153.0 / 255.0, blue: 1.0, alpha: 1.0)
    }
    
    @nonobjc class var greyishBrown: UIColor {
        return UIColor(white: 63.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var babyBlue: UIColor {
        return UIColor(red: 170.0 / 255.0, green: 218.0 / 255.0, blue: 251.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var tangerine: UIColor {
        return UIColor(red: 1.0, green: 150.0 / 255.0, blue: 0.0, alpha: 1.0)
    }
    
    @nonobjc class var silver: UIColor {
        return UIColor(red: 213.0 / 255.0, green: 213.0 / 255.0, blue: 220.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var strongSilver: UIColor {
        return UIColor(red: 237.0 / 255.0, green: 233.0 / 255.0, blue: 233.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var pastelBlue: UIColor {
        return UIColor(red: 179.0 / 255.0, green: 190.0 / 255.0, blue: 1.0, alpha: 1.0)
    }

    @nonobjc class var darkSkyBlue: UIColor {
        return UIColor(red: 74.0 / 255.0, green: 144.0 / 255.0, blue: 226.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var lineDisableColor : UIColor {
        return UIColor(white: 32.0 / 255.0, alpha: 0.5)
    }
    
    @nonobjc class var warmGrey: UIColor {
        return UIColor(white: 115.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var lightTan: UIColor {
        return UIColor(red: 250.0 / 255.0, green: 218.0 / 255.0, blue: 172.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var darkBlue: UIColor{
        return UIColor(red: 18.0 / 255.0, green: 38.0 / 255.0, blue: 180.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var skyGrey: UIColor{
        return UIColor(red: 249.0 / 255.0, green: 249.0 / 255.0, blue: 249.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var lavender: UIColor{
        return UIColor.init(red: 233/256, green: 235/256, blue: 251/256, alpha: 1)
    }
    
    @nonobjc class var lavenderBlue: UIColor{
        return UIColor.init(red: 179/256, green: 190/256, blue: 255/256, alpha: 1)
    }
        
    // to generate random colours
    static var random: UIColor {
        return UIColor(red: .random(in: 0...0.7),
                       green: .random(in: 0...0.7),
                       blue: .random(in: 0...0.7),
                       alpha: 1)
    }
}
