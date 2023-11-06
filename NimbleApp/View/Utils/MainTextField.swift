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
    var withError: Bool?
    var errorText: String?
    
    var body: some View {
        
        VStack (spacing: 0) {
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
            
            if let withError = withError, withError, let errorText = errorText {
                Text("\(Image(systemName: "xmark.app")) \(errorText)")
                    .font(.neuzeitSemiBold(14))
                    .foregroundStyle(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                    .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 0))
            }
        }
    }
}

struct MainTextFieldContainer: View {
    var body: some View {
        ZStack {
            Color.darkBackgroundColor
            
            VStack {
                MainTextField(title: "place", text: .constant("sdsd"), font: .neuzeitBold(17))
                
                MainTextField(title: "place", text: .constant("sdsd"), font: .neuzeitBold(17), withError: true, errorText: "Qskdhjjklhd")
            }
        }
    }
}

#Preview {
    MainTextFieldContainer()
}
