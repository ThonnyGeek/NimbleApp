//
//  Color+Extension.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 2/11/23.
//

import SwiftUI

extension Color {
    static let mainGradient = LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom)
    
    static let bodyTextColor = Color(#colorLiteral(red: 0.8126437068, green: 0.807677567, blue: 0.8034572005, alpha: 1)) // #15151A
    
    static let darkBackgroundColor = Color(#colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1)) // #1E1E1E
}
