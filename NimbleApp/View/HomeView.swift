//
//  HomeView.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 2/11/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    let backgroundColor = Color(#colorLiteral(red: 0.08235294118, green: 0.08235294118, blue: 0.1019607843, alpha: 1)) // #15151A
    
    var body: some View {
        ZStack {
//            backgroundColor
//                .ignoresSafeArea()
            background()
            
            header
            
            if viewModel.showMenu {
                sideMenu()
//                    .animation(.easeInOut, value: viewModel.showMenu)
                    .transition(.slide)
//                    .transition(.move(edge: .leading))
            }
        }
    }
    
    @ViewBuilder
    private func background() -> some View {
        ZStack {
            Image("firstHomeBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .frame(width: Constants.Sizes.width, height: Constants.Sizes.height)
        }
    }
    
    private var header: some View {
        HStack {
            VStack (alignment: .leading) {
                Text("Monday, JUNE 15".uppercased())
                    .font(.neuzeitSemiBold(13))
                    .foregroundStyle(.white)
                
                Text("Today")
                    .font(.neuzeitSemiBold(34))
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Button {
                withAnimation {
                    viewModel.showMenu = true
                }
            } label: {
                Image("profilePic")
                    .frame(width: 36, height: 36)
            }
        }
        .frame(width: Constants.Sizes.width * 0.9)
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0))
    }
    
    private func sideMenu() -> some View {
        ZStack {
            HStack (spacing: 0) {
                Color.black
                    .opacity(0.25)
                    .frame(width: Constants.Sizes.width * 0.35)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation {
                            viewModel.showMenu = false
                        }
                    }
                
                backgroundColor
                    .frame(width: Constants.Sizes.width * 0.65)
            }
            .frame(width: Constants.Sizes.width, height: Constants.Sizes.height)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    HomeView()
}
