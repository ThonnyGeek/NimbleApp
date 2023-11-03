//
//  MainTextField.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 2/11/23.
//

import SwiftUI

struct MainTextField: View {
    
    var title: String
    @Binding var text: String
    var font: Font
    var isSecured: Bool?
    
    var body: some View {
        
        ZStack {
            if let isSecured = isSecured, isSecured {
                SecureField("", text: $text, prompt: Text(title).foregroundColor(.white.opacity(0.3)))
            } else {
                TextField("", text: $text, prompt: Text(title).foregroundColor(.white.opacity(0.3)))
            }
        }
        .font(font)
        .foregroundColor(.white)
        .padding(.vertical, 20)
        .padding(.horizontal, 12)
        .background {
            Rectangle()
                .foregroundColor(.clear)
                .background(.white.opacity(0.18))
                .cornerRadius(12)
        }
    }
}
