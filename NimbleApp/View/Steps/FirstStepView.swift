//
//  FirstStepView.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 4/11/23.
//

import SwiftUI

struct FirstStepView: View {
    
    @Binding var selection: String?
    let options: [String]
    
    var body: some View {
        ZStack {
            CustomPicker(selection: $selection, options: options)
            
            
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

//#Preview {
//    FirstStepView()
//}
