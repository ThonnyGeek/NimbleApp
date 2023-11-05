//
//  QuestionNPSView.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 4/11/23.
//

import SwiftUI

struct QuestionNPSView: View {
    
    @Binding var selection: Int?
    
    var body: some View {
        ZStack  {
            
            HStack (spacing: 0) {
                ForEach(1...10, id: \.self) { number in
                    Button {
                        selection = number
                    } label: {
                        Text(number.description)
                            .font(.neuzeitSemiBold(20))
                            .foregroundStyle(.white.opacity(selection == number ? 1 : 0.4))
                    }
                    .frame(width: 33)
                    .frame(maxHeight: .infinity)
                    .contentShape(Rectangle())
                    
                    if number != 10 {
                        Rectangle()
                            .fill(.white)
                            .frame(width: 0.5)
                            .frame(maxHeight: .infinity)
                    }
                }
            }
            .frame(maxHeight: 57)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.white, lineWidth: 0.5)
            }
        }
        
    }
}

struct QuestionNPSViewContainer: View {
    
    @State var selection: Int? = 1
    
    var body: some View {
        
        VStack {
            QuestionNPSView(selection: $selection)
                .background {
                    Color.darkBackgroundColor
                        .frame(width: Constants.Sizes.width, height: Constants.Sizes.height)
                        .ignoresSafeArea()
                }
            
            Text("selection: \(selection?.description ?? "")")
        }
    }
}

#Preview {
    QuestionNPSViewContainer()
}
