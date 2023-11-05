//
//  RatingView.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 4/11/23.
//

import SwiftUI

struct RatingView: View {
    
    @Binding var selection: String?
    let rates = ["😡","😕","😐","🙂","😄"]

    
    var body: some View {
        HStack {
            
            ForEach(rates, id: \.self) { rate in
                Button {
                    withAnimation {
                        selection = rate
                    }
                } label: {
                    Text(rate)
                        .opacity(selection == rate ? 1 : 0.4)
                }
            }
        }
    }
}

struct RatingContainerView: View {
    
    @State var selection: String? = ""
    
    var body: some View {
        RatingView(selection: $selection)
            .background {
                Color.darkBackgroundColor
                    .frame(width: Constants.Sizes.width, height: Constants.Sizes.height)
                    .ignoresSafeArea()
            }
    }
}

#Preview {
    RatingContainerView()
}
