//
//  HomeView.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 2/11/23.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    
    @Binding var state: NavigationPath
    
    @FocusState var isFocused: Bool
    
    var body: some View {
        ZStack {
            
            bodyView()
            
            header
                .opacity(viewModel.surveySelected == nil ? 1 : 0)
                .transition(.opacity)
                .animation(.easeInOut(duration: 1), value: viewModel.surveySelected)
            
            SideMenu()
        }
        .onAppear {
            withAnimation(.timingCurve(.linear, duration: 2).repeatForever(autoreverses: false)) {
                viewModel.showSkeletonAnimation.toggle()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                viewModel.isLoadingData = false
            }
        }
    }
    
    private var header: some View {
        HStack {
            VStack (alignment: .leading) {
                Text(viewModel.dateFormatter.string(from: viewModel.presentDate).uppercased())
                    .font(.neuzeitSemiBold(13))
                    .foregroundStyle(.white)
                    .skeleton(show: viewModel.isLoadingData, showSkeletonAnimation: viewModel.showSkeletonAnimation)
                
                Text("Today")
                    .font(.neuzeitSemiBold(34))
                    .foregroundStyle(.white)
                    .skeleton(show: viewModel.isLoadingData, showSkeletonAnimation: viewModel.showSkeletonAnimation)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Button {
                withAnimation {
                    viewModel.showMenu = true
                }
            } label: {
                Image("profilePic")
                    .frame(width: 36, height: 36)
                    .clipShape(Circle())
                    .skeleton(show: viewModel.isLoadingData, showSkeletonAnimation: viewModel.showSkeletonAnimation)
            }
        }
        .frame(width: Constants.Sizes.width * 0.9)
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0))
    }
    
    @ViewBuilder
    private func SideMenu() -> some View {
        
        SideMenuView(isShowing: $viewModel.showMenu, direction: .trailing) {
            SideMenuViewContents(presentSideMenu: $viewModel.showMenu) {
                state.removeLast(state.count)
            }
            .frame(width: Constants.Sizes.width * 0.65)
            .frame(maxHeight: .infinity)
            .background(Color.darkBackgroundColor)
        }
    }
    
    @ViewBuilder
    private func tabView() -> some View {
        
        ZStack {
            
            TabView(selection: $viewModel.tabSelected) {
                ForEach(viewModel.homeTabs, id: \.self) { homeTab in
                    ZStack {
                        Image(homeTab.backgroundImgName)
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea()
                            .frame(width: viewModel.surveySelected != nil ? Constants.Sizes.width + 300 : Constants.Sizes.width, height: viewModel.surveySelected != nil ? Constants.Sizes.height + 300 : Constants.Sizes.height)
                            .transition(.scale)
                            .animation(.easeInOut(duration: 1.2), value: viewModel.surveySelected)
                        
                        Color.mainGradient
                            .frame(width: Constants.Sizes.width + 100)
                            .opacity(0.4)
                            .ignoresSafeArea()
                            .blur(radius: 10)
                        
                        
                        Color.darkBackgroundColor
                            .ignoresSafeArea()
                            .frame(width: Constants.Sizes.width, height: Constants.Sizes.height)
                            .opacity(viewModel.isLoadingData ? 1 : 0)
                            .transition(.opacity)
                            .animation(.easeInOut, value: viewModel.isLoadingData)
                    }
                    .tag(homeTab.id)
                    
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(maxWidth: .infinity, alignment: .leading)
            .ignoresSafeArea()
            .frame(width: Constants.Sizes.width, height: Constants.Sizes.height)
            .disabled(viewModel.surveySelected != nil)
            
            VStack (alignment: .leading, spacing: 20) {
                
                if viewModel.isLoadingData {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white.opacity(0.12))
                    .frame(width: 60, height: 20)
                    .opacity(0.8)
                    .skeleton(show: viewModel.isLoadingData, showSkeletonAnimation: viewModel.showSkeletonAnimation)
                } else {
                    PageIndicator(selectedPage: $viewModel.tabSelected, pageCount: 3)

                }
                
                HStack (alignment: .bottom, spacing: 20) {
                    VStack (alignment: .leading, spacing: 20) {
                        Text(viewModel.tabSelected.title)
                            .lineLimit(2)
                            .skeleton(show: viewModel.isLoadingData, showSkeletonAnimation: viewModel.showSkeletonAnimation)
                            .font(.neuzeitBold(28))
                            .foregroundStyle(.white)
                            .frame(height: 70)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(viewModel.tabSelected.body)
                            .skeleton(show: viewModel.isLoadingData, showSkeletonAnimation: viewModel.showSkeletonAnimation)
                            .font(.neuzeitBook(17))
                            .foregroundStyle(Color.bodyTextColor)
                            .lineLimit(2)
                    }
                    .animation(.easeInOut, value: viewModel.tabSelected)
                    .transition(.opacity)
                    
                    if !viewModel.isLoadingData {
                        Button {
                            viewModel.surveySelected = viewModel.tabSelected
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
                }
                .frame(maxWidth: .infinity)
            }
            .frame(width: Constants.Sizes.width * 0.9)
            .frame(maxHeight: .infinity, alignment: .bottomLeading)
            .padding(.bottom, 60)
            .opacity(viewModel.surveySelected == nil ? 1 : 0)
            .transition(.opacity)
            .animation(.easeInOut(duration: 1), value: viewModel.surveySelected)
        }
    }
    
    //MARK: Body View
    @ViewBuilder
    private func bodyView() -> some View {
        
        ZStack {
            tabView()
            
            confirmSurvey()
                .opacity((viewModel.surveySelected != nil && viewModel.fisrtStepOptionSelected == nil) ? 1 : 0)
//                .transition(.opacity)
                .transition(.slide)
                .animation(.easeInOut(duration: 1), value: viewModel.surveySelected)
                .animation(.easeInOut(duration: 1), value: viewModel.fisrtStepOptionSelected)
            
            fisrtStep()
                .opacity(viewModel.fisrtStepOptionSelected != nil ? 1 : 0)
                .transition(.slide)
                .animation(.easeInOut(duration: 1), value: viewModel.fisrtStepOptionSelected)
        }
    }
    
    @ViewBuilder
    private func confirmSurvey() -> some View {
        VStack (alignment: .leading, spacing: 20) {
            Button {
                viewModel.surveySelected = nil
            } label: {
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
            }
            
            Text(viewModel.tabSelected.title)
                .font(.neuzeitBold(34))
                .foregroundStyle(.white)
            
            Text(viewModel.tabSelected.body)
                .font(.neuzeitBook(17))
                .foregroundStyle(Color.bodyTextColor)
                .frame(maxHeight: .infinity, alignment: .top)
            
            Button {
                viewModel.fisrtStepOptionSelected = .somewhatFulfilled
            } label: {
                Text("Start survey")
                    .font(.neuzeitSemiBold(17))
            }
            .buttonStyle(PrimaryButtonStyle(backgroundColor: .white, cornerRadius: 10, verticalPadding: 20))
            .frame(width: 140)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .frame(width: Constants.Sizes.width * 0.9, height: Constants.Sizes.height * 0.9)
    }
    
    @ViewBuilder
    private func fisrtStep() -> some View {
        ZStack {
            VStack (alignment: .leading, spacing: 8) {
                Button {
                    viewModel.fisrtStepOptionSelected = nil
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
                
                Text("\(viewModel.surveyStep ?? 0)/5")
                    .font(.neuzeitSemiBold(15))
                    .foregroundStyle(.white.opacity(0.3))
                
                Text("How fulfilled did you feel during this WFH period?")
                    .font(.neuzeitSemiBold(36))
                    .foregroundStyle(.white)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .frame(width: Constants.Sizes.width * 0.9, height: Constants.Sizes.height * 0.9)
            
            ZStack {
                Picker("", selection: $viewModel.fisrtStepOptionSelected) {
                    ForEach(viewModel.fisrtStepOptions, id: \.self) { option in
                        Text(option.text)
                            .font(.neuzeitSemiBold(20))
                            .kerning(0.5)
                            .foregroundStyle(.white)
                    }
                }
                .pickerStyle(.wheel)
                
                VStack (spacing: 35) {
                    Rectangle()
                        .frame(width: Constants.Sizes.width * 0.5, height: 0.5)
                        .foregroundStyle(.white)
                    
                    Rectangle()
                        .frame(width: Constants.Sizes.width * 0.5, height: 0.5)
                        .foregroundStyle(.white)
                }
                .offset(x: 0, y: -1.5)
            }

        }
    }
    
}

#Preview {
    HomeView(state: .constant(NavigationPath()))
}
