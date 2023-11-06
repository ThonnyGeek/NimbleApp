//
//  PageIndicator.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 3/11/23.
//

import SwiftUI

struct PageIndicator: View {
    @Binding var selectedPage: SurveyListData
    @Binding var surveysData: [SurveyListData]
    let pageCount: Int

    var body: some View {
        HStack (spacing: 10) {
            
            ForEach(surveysData, id: \.self) { survey in
                Circle()
                    .fill(.white.opacity(selectedPage == survey ? 1 : 0.5))
                    .frame(width: 8, height: 8)
            }
        }
        .animation(.easeInOut, value: selectedPage)
        .transition(.opacity)
    }
}
