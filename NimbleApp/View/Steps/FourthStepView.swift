//
//  FourthStepView.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 4/11/23.
//

import SwiftUI

struct FourthStepView: View {
    
    @Binding var npsRate: Int?
    
    @State var componentWidth: CGFloat = 0
    
    var body: some View {
        VStack (spacing: 16) {
            QuestionNPSView(selection: $npsRate)
                .background {
                    GeometryReader { geometry in
                        Color.clear
                            .onAppear {
                                componentWidth = geometry.size.width
                            }
                    }
                }
            
            HStack {
                Text("Not at all Likely")
                    .font(.neuzeitSemiBold(17))
                    .foregroundStyle(.white.opacity(0.4))
                
                Spacer()
                
                Text("Extremely Likely")
                    .font(.neuzeitSemiBold(17))
                    .foregroundStyle(.white)
            }
            .frame(width: componentWidth)
        }
    }
}
