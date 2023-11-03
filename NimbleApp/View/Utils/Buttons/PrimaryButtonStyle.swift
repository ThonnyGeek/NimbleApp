//
//  PrimaryButtonStyle.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 2/11/23.
//

import SwiftUI

public struct PrimaryButtonStyle: ButtonStyle {
    public init(backgroundColor: Color, cornerRadius: CGFloat, verticalPadding: CGFloat) {
        
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.verticalPadding = verticalPadding
    }

    let backgroundColor: Color
    let cornerRadius: CGFloat
    let verticalPadding: CGFloat
    
    public func makeBody(configuration: Configuration) -> some View {
        PrimaryButtonStyleView(configuration: configuration, backgroundColor: backgroundColor, cornerRadius: cornerRadius, verticalPadding: verticalPadding)
    }
}

private extension PrimaryButtonStyle {
    struct PrimaryButtonStyleView: View {
        let configuration: PrimaryButtonStyle.Configuration
        let backgroundColor: Color
        let cornerRadius: CGFloat
        let verticalPadding: CGFloat

        var body: some View {
            return configuration.label
                .frame(maxWidth: .infinity)
                .padding(.vertical, verticalPadding)
                .background{
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(backgroundColor)
                }
                .opacity(configuration.isPressed ? 0.6 : 1.0)
                .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
                .contentShape(Rectangle())
        }
    }
}

#Preview {
    Button {
    } label: {
        Text("sldj")
    }
    .buttonStyle(PrimaryButtonStyle(backgroundColor: .red, cornerRadius: 10, verticalPadding: 17))
}
