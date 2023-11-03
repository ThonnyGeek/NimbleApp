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
    
    static func poppinsBold(_ size: CGFloat) -> Font {
        return Font.custom("Poppins-Bold", size: size)
    }
}

extension UIFont {
    static func poppinsBold(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Bold", size: size)!
    }
    
    static func poppinsSemiBold(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-SemiBold", size: size)!
    }
}
