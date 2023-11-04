//
//  View+Extension.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 3/11/23.
//

import SwiftUI

extension View {
    
    func skeleton(show: Bool, showSkeletonAnimation: Bool) -> some View {
        
        return ZStack {
            if show {
                self
                    .redacted(reason: show ? .placeholder : [])
                    .mask {
                        ZStack {
                            Color.white.opacity(0.12)
                            
                            Capsule()
                                .fill(LinearGradient(gradient: .init(colors: [.clear, .white, .clear]), startPoint: .top, endPoint: .bottom))
                                .rotationEffect(.init(degrees: 30))
                                .offset(x: showSkeletonAnimation ? 500 : -500)
                        }
                    }
            } else {
                self
            }
        }
        .animation(.easeInOut, value: show)
        .transition(.opacity)
    }
}
