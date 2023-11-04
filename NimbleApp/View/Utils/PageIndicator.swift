//
//  PageIndicator.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 3/11/23.
//

import SwiftUI

struct PageIndicator: View {
    @Binding var selectedPage: HomeTab
    let pageCount: Int

    var body: some View {
        HStack (spacing: 10) {
            Circle()
                .fill(.white.opacity(selectedPage == .workingFromHome ? 1 : 0.5))
                .frame(width: 8, height: 8)
            
            Circle()
                .fill(.white.opacity(selectedPage == .careerTraining ? 1 : 0.5))
                .frame(width: 8, height: 8)
            
            Circle()
                .fill(.white.opacity(selectedPage == .inclusionBelongig ? 1 : 0.5))
                .frame(width: 8, height: 8)
        }
        .animation(.easeInOut, value: selectedPage)
        .transition(.opacity)
    }
}
