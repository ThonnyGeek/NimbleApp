//
//  HomeView.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 2/11/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel: HomeViewModel = HomeViewModel(homeService: HomeService())
    
    @Binding var state: NavigationPath
    
    @FocusState var isFocused: Bool
    
    var body: some View {
        ZStack {
            
            tabView()
            
            Group {
                if viewModel.showMainInfo {
                    Group {
                        header
                        
                        mainScreen()
                    }
                    .transition(.asymmetric(insertion: .opacity, removal: .move(edge: .leading)))
                }
                
                if viewModel.showConfirmSurvey {
                    confirmSurvey()
                        .transition(.asymmetric(insertion: viewModel.surveySelected == nil ? .move(edge: .trailing) : .move(edge: .leading), removal: viewModel.surveySelected == nil ? .move(edge: .leading) : .move(edge: .trailing)))
                }
                
                if viewModel.showFirstStep {
                    StepsView(selection: $viewModel.fisrtStepOptionSelected, fisrtStepOptions: viewModel.fisrtStepOptions) {
                        withAnimation {
                            viewModel.showConfirmSurvey.toggle()
                            viewModel.showFirstStep.toggle()
                        }
                    }
                    .transition(.move(edge: .trailing))
                }
            }
            .zIndex(1.0)
            
            
            sideMenu()
                .zIndex(1.0)
        }
        .background(.gray)
        .onAppear {
            
            viewModel.showSkeletonAnimation = true
            
            if !viewModel.isLoadingData {
                viewModel.isLoadingData = true
            }
            
            withAnimation(.timingCurve(.linear, duration: 2).repeatForever(autoreverses: false)) {
                viewModel.showSkeletonAnimation.toggle()
            }
        }
    }
    
    @ViewBuilder
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
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0))
    }
    
    @ViewBuilder
    private func sideMenu() -> some View {
        
        SideMenuView(isShowing: $viewModel.showMenu, direction: .trailing) {
            SideMenuViewContents(presentSideMenu: $viewModel.showMenu, userName: "", userAvatar: "") {
                state.removeLast(state.count)
                UserManager.shared.logout()
            }
            .frame(width: Constants.Sizes.width * 0.65)
            .frame(maxHeight: .infinity)
            .background(Color.darkBackgroundColor)
        }
    }
    
    @ViewBuilder
    private func tabView() -> some View {
        
        ZStack {
            ScrollView {
                TabView(selection: $viewModel.tabSelected) {
                    
                    ForEach(viewModel.surveysData, id: \.self) { survey in
                        ZStack {
                            
                            let imageHeight = Constants.Sizes.height + (UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0)
                            
                            AsyncImage(url: URL(string: "\(survey.attributes.coverImageURL)l")) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .scaleEffect(viewModel.surveySelected != nil ? 1.2 : 1, anchor: .bottom)
                                    .frame(width: Constants.Sizes.width, height: Constants.Sizes.height + (UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0))
                                    .clipped()
                                    .transition(.scale)
                                    .animation(.easeInOut(duration: 1.2), value: viewModel.surveySelected)
                            } placeholder: {
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 150)
                                    .foregroundColor(.gray)
                                    .frame(maxWidth: .infinity)
                            }
                                
                            
                            Color.mainGradient
                                .frame(width: Constants.Sizes.width + 100)
                                .opacity(0.5)
                                .ignoresSafeArea()
                                .blur(radius: 10)
                            
                            Color.black
                                .ignoresSafeArea()
                                .blur(radius: 10)
                                .opacity(viewModel.showFirstStep ? 0.5 : 0)
                            
                            Color.darkBackgroundColor
                                .ignoresSafeArea()
                                .frame(width: Constants.Sizes.width, height: Constants.Sizes.height)
                                .opacity(viewModel.isLoadingData ? 1 : 0)
                                .transition(.opacity)
                                .animation(.easeInOut, value: viewModel.isLoadingData)
                            
                            if survey == viewModel.surveysData[viewModel.surveysData.count - 1] {
                                Color.clear
                                    .onAppear {
                                        guard let surveysResponseMeta = viewModel.surveysResponseMeta else { return }
                                        if surveysResponseMeta.page + 1 < surveysResponseMeta.pages {
                                            viewModel.fetchSurveys(page: surveysResponseMeta.page + 1)
                                        }
                                    }
                            }
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(maxWidth: .infinity, alignment: .leading)
                .ignoresSafeArea()
                .frame(width: Constants.Sizes.width, height: Constants.Sizes.height)
                .disabled(viewModel.showConfirmSurvey)
            }
            .ignoresSafeArea()
            .frame(width: Constants.Sizes.width, height: Constants.Sizes.height)
            .refreshable {
                viewModel.surveysData = []
//                self.tabSelected = firstSelection
                viewModel.fetchSurveys(page: 1)
            }
        }
    }

    
    @ViewBuilder
    private func mainScreen() -> some View {
        VStack (alignment: .leading, spacing: 20) {
            
            if viewModel.isLoadingData {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white.opacity(0.12))
                .frame(width: 60, height: 20)
                .opacity(0.8)
                .skeleton(show: viewModel.isLoadingData, showSkeletonAnimation: viewModel.showSkeletonAnimation)
            } else {
                PageIndicator(selectedPage: $viewModel.tabSelected, surveysData: $viewModel.surveysData, pageCount: viewModel.surveysData.count)
            }
            
            HStack (alignment: .bottom, spacing: 20) {
                VStack (alignment: .leading, spacing: 20) {
                    Text(viewModel.tabSelected.attributes.title ?? "")
                        .lineLimit(2)
                        .skeleton(show: viewModel.isLoadingData, showSkeletonAnimation: viewModel.showSkeletonAnimation)
                        .font(.neuzeitBold(28))
                        .foregroundStyle(.white)
                        .frame(height: 70)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(viewModel.tabSelected.attributes.description ?? "")
                        .skeleton(show: viewModel.isLoadingData, showSkeletonAnimation: viewModel.showSkeletonAnimation)
                        .font(.neuzeitBook(17))
                        .foregroundStyle(Color.bodyTextColor)
                        .lineLimit(2)
                }
                .animation(.easeInOut, value: viewModel.tabSelected)
                .transition(.opacity)
                
                if !viewModel.isLoadingData {
                    Button {
                        withAnimation {
//                                viewModel.surveySelected = viewModel.tabSelected
                            viewModel.showMainInfo.toggle()
                            viewModel.showConfirmSurvey.toggle()
                        }
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
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .padding(.bottom, 60)
    }
    
    @ViewBuilder
    private func confirmSurvey() -> some View {
        VStack (alignment: .leading, spacing: 20) {
            Button {
                withAnimation {
                    viewModel.showConfirmSurvey.toggle()
                    viewModel.showMainInfo.toggle()
                }
                viewModel.surveySelected = nil
            } label: {
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
            }
            
            Text(viewModel.tabSelected.attributes.title ?? "")
                .font(.neuzeitBold(34))
                .foregroundStyle(.white)
            
            Text(viewModel.tabSelected.attributes.description ?? "")
                .font(.neuzeitBook(17))
                .foregroundStyle(Color.bodyTextColor)
                .frame(maxHeight: .infinity, alignment: .top)
            
            Button {
                withAnimation {
                    viewModel.showConfirmSurvey.toggle()
                    viewModel.showFirstStep.toggle()
                }
                viewModel.surveySelected = viewModel.tabSelected
            } label: {
                Text("Start survey")
                    .font(.neuzeitSemiBold(17))
            }
            .buttonStyle(PrimaryButtonStyle(backgroundColor: .white, cornerRadius: 10, verticalPadding: 20))
            .frame(width: 140)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .frame(width: Constants.Sizes.width * 0.9, height: Constants.Sizes.height * 0.9)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
}

#Preview {
    HomeView(viewModel: HomeViewModel(homeService: HomeService()), state: .constant(NavigationPath()))
}
