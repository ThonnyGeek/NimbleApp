//
//  StepsView.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 4/11/23.
//

import SwiftUI

/*
 enum HomeFirstStep: Hashable, CaseIterable {
     case veryFulfilled
     case somewhatFulfilled
     case somewhatUnfulfilled
     case veryUnfulfilled
     
     var text: String {
         switch self {
         case .veryFulfilled:
             return "Very fulfilled"
         case .somewhatFulfilled:
             return "Somewhat fulfilled"
         case .somewhatUnfulfilled:
             return "Somewhat unfulfilled"
         case .veryUnfulfilled:
             return "Very unfulfilled"
         }
     }
 }
 */

struct StepsView: View {
    
    
    @Binding var selection: String?
    let fisrtStepOptions: [HomeFirstStep]
//    @State var selection: String = HomeFirstStep.somewhatFulfilled.text
    let firstStepOptions: [String] = HomeFirstStep.allCases.map { $0.text }
    var closeViewAction: () -> Void
    
    @State var page: Int = 1
    @State var rate: String? = ""
    @State var npsRate: Int?
    @State var choicesSelected: [String] = []
    
    let titles: [String] = [
        "How fulfilled did you feel during this WFH period?",
        "How did WFH change your productivity?",
        "I have a separate space to work (room or living room).",
        "Question NPS",
        "Question Multi Choice",
        "Your contact information",
        "Please share with us what you think about our service"
    ]
    
    var body: some View {
        ZStack {
            VStack (alignment: .leading, spacing: 20) {
                Button {
                    closeViewAction()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.white.opacity(0.8))
                        .fontWeight(.bold)
                        .frame(width: 28, height: 28)
                        .padding(5)
                        .background {
                            Circle()
                                .foregroundStyle(.white.opacity(0.35))
                        }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.bottom, 24)
                .padding(.horizontal, 20)
                
                Text("\(page)/5")
                    .font(.neuzeitSemiBold(15))
                    .foregroundStyle(.white.opacity(0.3))
                    .transition(.slide)
                    .padding(.horizontal, 20)
                
                ZStack {
                    if page == 1 {
                        Text(titles[0])
                            .font(.neuzeitSemiBold(36))
                            .foregroundStyle(.white)
                            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                            .padding(.horizontal, 20)
                    }
                    
                    if page == 2 {
                        Text(titles[1])
                            .font(.neuzeitSemiBold(36))
                            .foregroundStyle(.white)
                            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                            .padding(.horizontal, 20)
                    }
                    
                    if page == 3 {
                        Text(titles[2])
                            .font(.neuzeitSemiBold(36))
                            .foregroundStyle(.white)
                            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                            .padding(.horizontal, 20)
                    }
                    
                    if page == 4 {
                        Text(titles[3])
                            .font(.neuzeitSemiBold(36))
                            .foregroundStyle(.white)
                            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                            .padding(.horizontal, 20)
                    }
                    
                    if page == 5 {
                        Text(titles[4])
                            .font(.neuzeitSemiBold(36))
                            .foregroundStyle(.white)
                            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                            .padding(.horizontal, 20)
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .frame(maxWidth: .infinity)
            .overlay {
                
                switch page {
                case 1:
                    FirstStepView(selection: $selection, options: firstStepOptions)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                case 2:
                    RatingView(selection: $rate)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                case 3:
                    ThirdStepView(selection: .constant(""))
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                case 4:
                    FourthStepView(npsRate: $npsRate)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                case 5:
                    FifthStepView(selection: $choicesSelected)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                default:
                    EmptyView()
                }
            }

            Button("") {
                nextPage()
            }
            .buttonStyle(SecondaryButtonStyle())
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
        }
    }
    
    private func nextPage() {
        withAnimation {
            page += 1
        }
    }
}

#Preview {
    ZStack {
        Color.darkBackgroundColor
        
        StepsView(selection: .constant(""), fisrtStepOptions: [HomeFirstStep.somewhatFulfilled]) {
            //
        }
        .ignoresSafeArea()
    }
}
