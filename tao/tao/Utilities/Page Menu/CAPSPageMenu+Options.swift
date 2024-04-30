//  CAPSPageMenu+Options.swift
//
//  Niklas Fahl
//
//  Copyright (c) 2014 The Board of Trustees of The University of Alabama All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  Neither the name of the University nor the names of the contributors may be used to endorse or promote products derived from this software without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
//  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
//  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
//  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import UIKit

public enum CAPSPageMenuOption {
    case selectionIndicatorHeight(CGFloat)
    case menuItemSeparatorWidth(CGFloat)
    case scrollMenuBackgroundColor(UIColor)
    case viewBackgroundColor(UIColor)
    case bottomMenuHairlineColor(UIColor)
    case selectionIndicatorColor(UIColor)
    case menuItemSeparatorColor(UIColor)
    case menuMargin(CGFloat)
    case menuItemMargin(CGFloat)
    case menuHeight(CGFloat)
    case selectedMenuItemLabelColor(UIColor)
    case unselectedMenuItemLabelColor(UIColor)
    case useMenuLikeSegmentedControl(Bool)
    case menuItemSeparatorRoundEdges(Bool)
    case menuItemFont(UIFont)
    case menuItemSeparatorPercentageHeight(CGFloat)
    case menuItemWidth(CGFloat)
    case enableHorizontalBounce(Bool)
    case addBottomMenuHairline(Bool)
    case menuItemWidthBasedOnTitleTextWidth(Bool)
    case titleTextSizeBasedOnMenuItemWidth(Bool)
    case scrollAnimationDurationOnMenuItemTap(Int)
    case centerMenuItems(Bool)
    case hideTopMenuBar(Bool)
    
    public static func defaultOptions1(isHairlineNeeded : Bool = true, backgroundColor : UIColor = UIColor.TAO_TBlue) -> [CAPSPageMenuOption] {
        return [
            .scrollMenuBackgroundColor(backgroundColor),
            .menuItemSeparatorWidth(24),
            .viewBackgroundColor(UIColor.gray),
            .selectionIndicatorColor(UIColor.red),
            .bottomMenuHairlineColor(isHairlineNeeded ? UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1) : .clear),
            .menuItemFont(UIFont(name: "Roboto-Medium", size: 15) ?? UIFont.boldSystemFont(ofSize: 15)),
            .menuHeight(50),
            .menuMargin(0.0),
            .menuItemWidth(UIScreen.main.bounds.width/2),
            .centerMenuItems(true),
            .menuItemWidthBasedOnTitleTextWidth(false),
            .selectedMenuItemLabelColor(UIColor.TAO_TBlue),
            .unselectedMenuItemLabelColor(UIColor.TAO_TBlue),
            .selectionIndicatorHeight(2.0),
            .enableHorizontalBounce(false)            
            
        ]
    }
    
    
    
    public static func defaultOptions(isHairlineNeeded : Bool = true, backgroundColor : UIColor = UIColor.white) -> [CAPSPageMenuOption] {
        return [
            .scrollMenuBackgroundColor(backgroundColor),
            .menuItemSeparatorWidth(0),
            .viewBackgroundColor(UIColor.gray),
            .selectionIndicatorColor(UIColor(hex: "#363D43") ?? UIColor.TAO_DarkGray),
            .bottomMenuHairlineColor(isHairlineNeeded ? UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 0.5) : .clear),
            .menuItemFont(UIFont(name: "Roboto-Medium", size: 15) ?? UIFont.boldSystemFont(ofSize: 15)),
            .menuHeight(50),
            .menuMargin(0.0),
            .menuItemMargin(0.0),
            .centerMenuItems(false),
            .menuItemWidth(UIScreen.main.bounds.width/2),
            .menuItemWidthBasedOnTitleTextWidth(true),
            .selectedMenuItemLabelColor(UIColor(hex: "#363D43") ?? UIColor.TAO_DarkGray),
            .unselectedMenuItemLabelColor(UIColor.TAO_LightGray),
            .selectionIndicatorHeight(2.0),
            .enableHorizontalBounce(false)
            
        ]
    }
    
    
}


