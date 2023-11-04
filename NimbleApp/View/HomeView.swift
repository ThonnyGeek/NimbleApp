//
//  HomeView.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 2/11/23.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    
    let backgroundColor = Color(#colorLiteral(red: 0.08235294118, green: 0.08235294118, blue: 0.1019607843, alpha: 1)) // #15151A
    
//    var body: some View {
//        ZStack {
////            backgroundColor
////                .ignoresSafeArea()
//            background()
//            
//            header
//            
//            SideMenu()
//        }
//    }
    
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
                Text(viewModel.dateFormatter.string(from: viewModel.presentDate).uppercased())
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
    
    @ViewBuilder
    private func SideMenu() -> some View {
        let backgroundColor = Color(#colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1)) // #1E1E1E
        
        SideMenuView(isShowing: $viewModel.showMenu, direction: .trailing) {
            SideMenuViewContents(presentSideMenu: $viewModel.showMenu)
                .frame(width: Constants.Sizes.width * 0.65)
                .frame(maxHeight: .infinity)
                .background(backgroundColor)    
        }
    }
    
    @ViewBuilder
//    private func tabView() -> some View {
    var body: some View {
        ZStack {
            
//            background()
            
            TabView(selection: $viewModel.tabSelected) {
                ForEach(viewModel.homeTabs, id: \.self) { homeTab in
                    ZStack {
                        Image(homeTab.backgroundImgName)
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea()
                            .frame(width: Constants.Sizes.width, height: Constants.Sizes.height)
                    }
                    .tag(homeTab.id)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(maxWidth: .infinity, alignment: .leading)
            .ignoresSafeArea()
            .frame(width: Constants.Sizes.width, height: Constants.Sizes.height)
            
            VStack (alignment: .leading, spacing: 20) {
                PageIndicator(selectedPage: $viewModel.tabSelected, pageCount: 3)
                
                
                HStack (spacing: 10) {
                    VStack (alignment: .leading, spacing: 20) {
                        Text(viewModel.tabSelected.title)
                            .lineLimit(2)
                            .font(.neuzeitBold(28))
                            .foregroundStyle(.white)
                            .frame(height: 70)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .border(.red)
                        
                        Text(viewModel.tabSelected.body)
                            .font(.neuzeitBook(17))
                            .foregroundStyle(.white)
                    }
                    
                    Button {
                    } label: {
                       Image(systemName: "chevron.right")
                            .resizable()
                            .scaledToFit()
                            .fontWeight(.semibold)
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.black)
                            .frame(width: 56, height: 56)
                            .background {
                                Circle()
                                    .fill(.white)
                            }
                    }
                }
                .frame(maxWidth: .infinity)
                .border(.red)
            }
            .frame(width: Constants.Sizes.width * 0.9, height: Constants.Sizes.height * 0.6, alignment: .bottomLeading)
        }
    }
}

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

#Preview {
    HomeView()
}
