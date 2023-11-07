//
//  MainViewModel.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 2/11/23.
//

import SwiftUI
import Combine
import Alamofire

final class MainViewModel: ObservableObject {
    
    //MARK: Variables
    @Published var welcomeFlowState: WelcomeFlowState
    
    @Published var showLogo = false
    @Published var showLogin = false
    @Published var showPasswordRecoveryView = false
    
    
    @Published var emailText: String = "" {
        didSet {
            checkEmailText()
        }
    }
    
    @KeyChain(key:  "user_email", account: Constants.keyAccountName) var storedEmail
    @Published var emailIsValid: Bool = true
    @Published var emailErrorLabel: String = "This field can not be empty"
    
    
    @Published var passwordText: String = "" {
        didSet {
            checkPasswordText()
        }
    }
    @KeyChain(key:  "user_password", account: Constants.keyAccountName) var storedPassword
    @Published var passwordIsValid: Bool = true
    @Published var passwordErrorLabel: String? = "This field can not be empty"
    
    var loginButtonIsDisabled: Bool {
        if showPasswordRecoveryView {
            return (emailText.isEmpty || !emailIsValid)
        } else {
            return (emailText.isEmpty || !emailIsValid) || passwordText.isEmpty
        }
    }
    
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Constants
    let authService: AuthServiceProtocol// = AuthService()
    
    //MARK: init
    init(welcomeFlowState: WelcomeFlowState, authService: AuthServiceProtocol) {
        self.welcomeFlowState = welcomeFlowState
        self.authService = authService
        
        print("MainViewModel init() ")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation {
                self.showLogo = true
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                self.showLogin = true
            }
        } 
    }
    
    
    //MARK: Functions
    
    func checkEmailText() {
        DispatchQueue.main.async {
            withAnimation {
                if !self.emailText.isEmpty {
                    self.emailIsValid = self.emailText.isValidEmail
                    self.emailErrorLabel = "Invalid email"
                } else {
                    self.emailIsValid = false
                    self.emailErrorLabel = "This field can not be empty"
                }
            }
        }
    }
    
    func checkPasswordText() {
       
        DispatchQueue.main.async {
            withAnimation {
                if !self.passwordText.isEmpty {
                    self.passwordIsValid = true
                } else {
                    self.passwordIsValid = false
                    self.passwordErrorLabel = "This field can not be empty"
                }
            }
        }
    }
    
    final func checkTextFields() {
        checkEmailText()
        checkPasswordText()
    }
    
    final func mainButtonAction() {
        if showPasswordRecoveryView {
            //Password Recovery
            passwordRecovery()
        } else {
            //Log In
            login {
                self.openHome()
            }
        }
    }
    
    func openHome() {
        welcomeFlowState.coverPath.append(WelcomeLink.home)
    }
    
    final func login(onSuccess: (() -> Void)? = nil) {
        InAppNotificationManager.shared.showLoading()
        
        let params: Parameters = [
            "grant_type": "password",
            "email": self.emailText,
            "password": self.passwordText
        ]
        
        self.authService.login(params: params)
            .sink(receiveCompletion: Constants.onReceive) { result in
                
                InAppNotificationManager.shared.hideLoading()
                
                guard let data = result.data else {
                    InAppNotificationManager.shared.showNotification("Login: \(result.errors?.first?.code ?? "API connection error")", subtitle: result.errors?.first?.detail)
                    return
                }
                
                self.storeData()
                
                UserManager.shared.authorize(access_token: data.attributes.accessToken, expires_in: data.attributes.expiresIn.description, refresh_token: data.attributes.refreshToken)
                
                print("result: \(result)")
                
                if let onSuccess = onSuccess {                
                    onSuccess()
                }
            }
            .store(in: &subscriptions)
    }
    
    final func storeData() {
        print("self.storedEmail: \(String(describing: self.storedEmail)) - self.storedPassword: \(String(describing: self.storedPassword))")
        
        self.storedEmail = self.emailText.data(using: .utf8)
        self.storedPassword = self.passwordText.data(using: .utf8)
    }
    
    final func passwordRecovery() {
        self.authService.passwordRecovery(email: self.emailText)
            .sink(receiveCompletion: Constants.onReceive) { result in
                print("result: \(result)")
                
                guard let data = result.meta else {
                    InAppNotificationManager.shared.showNotification(result.errors?.first?.code ?? "API connection error", subtitle: result.errors?.first?.detail)
                    return
                }
                
                InAppNotificationManager.shared.showNotification(data.message)
                
            }
            .store(in: &subscriptions)
    }
}
