//
//  FifthStepView.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 4/11/23.
//

import SwiftUI

struct FifthStepView: View {
    
    @Binding var selection: [String]
    
    var body: some View {
        
        VStack (spacing: 30) {
            ForEach(1...3, id: \.self) { option in
                
                var isSelected: Bool {
                    if selection.count >= (option + 1) {
                        print("selection.count: \(selection.count) - option: \(option)")
                        return (selection[option] == option.description)
                    } else {
                        return false
                    }
                }
                
                button(option: option, isSelected: selection.contains(option.description)) {
                    
                    if selection.contains(option.description) {
                        withAnimation {
                            selection.removeAll { $0 == option.description}
                        }
                    } else {
                        if selection.isEmpty {
                            selection = [option.description]
                        } else {
                            selection.append(option.description)
                        }
                    }
                }
            }
        }
        .background {
            VStack (spacing: 45) {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: Constants.Sizes.width / 2, height: 0.5)
                    .background(.white)
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: Constants.Sizes.width / 2, height: 0.5)
                    .background(.white)
            }
        }
    }
    
    @ViewBuilder
    private func button(option: Int, isSelected: Bool, selectAction: @escaping () -> Void) -> some View {
        Button {
            selectAction()
        } label: {
            HStack (spacing: 99) {
                Text("Choice \(option)")
                    .font(isSelected ? .neuzeitSemiBold(20) : .neuzeitBook(20))
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                } else {
                    Circle()
                        .stroke(.white.opacity(isSelected ? 1 : 0.4), lineWidth: 0.5)
                        .frame(width: 25, height: 25)
                }
            }
            .foregroundStyle(.white.opacity(isSelected ? 1 : 0.4))
        }
    }
}

struct FifthStepViewContainer: View {
    
    @State var selection: [String] = []
    
    var body: some View {
        ZStack {
            Color.darkBackgroundColor
            
            FifthStepView(selection: $selection)
        }
    }
}

#Preview {
    FifthStepViewContainer()
}
