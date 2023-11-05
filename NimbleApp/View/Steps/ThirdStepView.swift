//
//  ThirdStepView.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 4/11/23.
//

import SwiftUI

struct ThirdStepView: View {
    
    @Binding var selection: String?
    
    var body: some View {
        CustomPicker(selection: $selection, options: ["Yes", "No"])
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
}
