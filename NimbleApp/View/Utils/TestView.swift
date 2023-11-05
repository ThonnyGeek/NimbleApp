//
//  TestView.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 4/11/23.
//

import SwiftUI

final class TestViewModel: ObservableObject {
    
    //MARK: Variables
    @Published var showMainInfo: Bool = true
    
    //MARK: Constants
    
    //MARK: init
    
    //MARK: Functions
}

struct TestView: View {

//    @ObservedObject var testViewModel = TestViewModel()
    
    var body: some View {
        ZStack  {
            
            HStack (spacing: 10) {
                ForEach(1...10, id: \.self) { number in
                    Button {
                    } label: {
                        Text(number.description)
                            .font(.neuzeitSemiBold(20))
                            .foregroundStyle(.white)
                    }
//                    .padding(.horizontal, 2.5)
                    
                    if number != 10 {
                        Rectangle()
                            .fill(.white)
                            .frame(width: 0.5)
                            .frame(maxHeight: .infinity)
                    }
                }
            }
//            .padding(.vertical, 20)
            .padding(.horizontal, 10)
            .frame(maxHeight: 60)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.white, lineWidth: 0.5)
            }
        }
        .background {
            Color.darkBackgroundColor
                .frame(width: Constants.Sizes.width, height: Constants.Sizes.height)
                .ignoresSafeArea()
        }
    }
    
}

#Preview {
    TestView()
}
