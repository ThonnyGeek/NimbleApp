//
//  SecondaryButtonStyle.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 4/11/23.
//

import SwiftUI

//struct SecondaryButtonStyle: View {

public struct SecondaryButtonStyle: ButtonStyle {
    public init() {
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        SecondaryButtonStyleView(configuration: configuration)
    }
}

private extension SecondaryButtonStyle {
    struct SecondaryButtonStyleView: View {
        let configuration: SecondaryButtonStyle.Configuration

        var body: some View {
            
            return Image(systemName: "chevron.right")
                .resizable()
                .scaledToFit()
                .fontWeight(.semibold)
                .frame(width: 20, height: 20)
                .foregroundStyle(.black)
                .frame(width: 56, height: 56)
                .background {
                    Circle()
                        .fill(.white)
                }
                .opacity(configuration.isPressed ? 0.6 : 1.0)
                .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
                .contentShape(Circle())
        }
    }
}

#Preview {
    
    ZStack {
        
        Color.darkBackgroundColor
        
        Button("") {
            
        }
        .buttonStyle(SecondaryButtonStyle())
    }
}
