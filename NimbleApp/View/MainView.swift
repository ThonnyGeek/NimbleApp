//
//  MainView.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 2/11/23.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel: MainViewModel
    
    @StateObject var state = WelcomeFlowState()
    
    var body: some View {
        WelcomeFlowCoordinator(state: state, content: content)
    }
    
    @ViewBuilder private func content() -> some View {
        ZStack {
            background
            
            VStack (spacing: 109) {
                if viewModel.showLogo {
                    VStack (spacing: 43) {
                        Image("mainLogoWhite")
                        
                        if viewModel.showPasswordRecoveryView {
                           Text("Enter your email to receive instructions for resetting your password.")
                                .font(.neuzeitBook(17))
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white)
                                .frame(width: Constants.Sizes.width * 0.9)
                        }
                    }
                }
                
                if viewModel.showLogin {                
                    viewContent()
                }
            }
            .offset(CGSize(width: 0, height: viewModel.showLogin ? -50 : 0))
            
            if viewModel.showPasswordRecoveryView {
                Button {
                    withAnimation {
                        viewModel.showPasswordRecoveryView = false
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .scaledToFit()
                        .frame(width: 15, height: 30)
                }
                .frame(maxWidth: Constants.Sizes.width * 0.9, maxHeight: Constants.Sizes.height - 100, alignment: .topLeading)
            }
        }
        .onAppear {
            if UserManager.shared.isUserAuthorized {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    print("UserManager.shared.accessToken: \(String(describing: UserManager.shared.accessToken))")
                    openHome()
                }
            }
        }
    }
    
    private var background: some View {
        ZStack {
            Image("mainBackground")
                .resizable()
                .scaledToFill()
                .frame(width: Constants.Sizes.width, height: Constants.Sizes.height)
                .ignoresSafeArea()
                .blur(radius: viewModel.showLogin ? 20 : 0, opaque: true)
            
            VStack (spacing: 0) {
                LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom)
                
                Color.black
                    .frame(height: Constants.Sizes.height * 0.5)
            }
            .ignoresSafeArea()
            .opacity(viewModel.showLogin ? 1 : 0)
        }
    }
    
    private func viewContent() -> some View {
        VStack (spacing: 20) {
            MainTextField(title: "Email", text: $viewModel.emailText, font: .neuzeitBook(17), withError: !viewModel.emailIsValid, errorText: viewModel.emailErrorLabel)
            
            if !viewModel.showPasswordRecoveryView {
                MainTextField(title: "Password", text: $viewModel.passwordText, font: .neuzeitBook(17), isSecured: true, withError: !viewModel.passwordIsValid, errorText: viewModel.passwordErrorLabel)
                    .overlay {
                        Button {
                            withAnimation {
                                viewModel.showPasswordRecoveryView = true
                            }
                        } label: {
                            Text("Forgot?")
                                .font(.neuzeitBook(17))
                                .foregroundColor(.white.opacity(0.3))
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .topTrailing)
                        .padding(.init(top: 20, leading: 0, bottom: 0, trailing: 20))
                    }
            }
            
            Button {
                if viewModel.showPasswordRecoveryView {
                    //Password Recovery
                    openHome()
                } else {
                    //Log In
                    viewModel.login {
                        openHome()
                    }
                }
            } label: {
                Text(viewModel.showPasswordRecoveryView ? "Reset" : "Log In")
                    .font(.neuzeitSemiBold(17))
                    .foregroundStyle(.black)
            }
            .buttonStyle(PrimaryButtonStyle(backgroundColor: .white, cornerRadius: 10, verticalPadding: 17))
            .disabled(viewModel.loginButtonIsDisabled)
            .opacity(viewModel.loginButtonIsDisabled ? 0.5 : 1)
            .onTapGesture {
                if viewModel.loginButtonIsDisabled {
                    viewModel.checkTextFields()
                }
            }
        }
        .frame(width: Constants.Sizes.width * 0.9)
    }
    
    private func openHome() {
        state.coverPath.append(WelcomeLink.home)
    }
}

#Preview {
    
    MainView(viewModel: MainViewModel())
        .onAppear {
            UserManager.shared.authorize(access_token: "NuyBuY3BP4wYrc9AS5mHJP7DDvZLTn-zUG68FGydOXI", expires_in: "", refresh_token: "")
        }
}

