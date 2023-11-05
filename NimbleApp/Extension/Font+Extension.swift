//
//  UIFont+Extension.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 2/11/23.
//

import SwiftUI

extension Font {
    static func neuzeitBook(_ size: CGFloat) -> Font {
        return Font.custom("NeuzeitSLTStd-Book", size: size)
    }
    
    static func neuzeitSemiBold(_ size: CGFloat) -> Font {
        return Font.custom("Neuzeit S LT Std Book Heavy", size: size)
    }
    
    static func neuzeitBold(_ size: CGFloat) -> Font {
        return Font.custom("Neuzeit S LT BookHeavy", size: size)
    }
}

extension UIFont {
    static func neuzeitBook(_ size: CGFloat) -> UIFont {
        return UIFont(name: "NeuzeitSLTStd-Book", size: size)!
    }
    
    static func neuzeitSemiBold(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Neuzeit S LT Std Book Heavy", size: size)!
    }
    
    static func neuzeitBold(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Neuzeit S LT BookHeavy", size: size)!
    }
}
