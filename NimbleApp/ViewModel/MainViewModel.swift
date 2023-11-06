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
    @Published final var showLogo = false
    @Published final var showLogin = false
    @Published var showPasswordRecoveryView = false
    
    
    @Published var emailText: String = ""
    @KeyChain(key:  "user_email", account: Constants.keyAccountName) var storedEmail //: String = ""
    
    @Published var passwordText: String = ""
    @KeyChain(key:  "user_password", account: Constants.keyAccountName)  var storedPassword //: String = ""
    
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Constants
    let authService: AuthService = AuthService()
    
    //MARK: init
    init() {
//        print("self.storedEmail: \(String(data: self.storedEmail ?? Data(), encoding: .utf8)) - self.storedPassword: \(String(data: self.storedPassword ?? Data(), encoding: .utf8))")
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
    
    func login(onSuccess: @escaping () -> Void) {
        storeData()
        
        let params: Parameters = [
            "grant_type": "password",
            "email": self.emailText,
            "password": self.passwordText
        ]
        
        self.authService.login(params: params)
            .sink(receiveCompletion: Constants.onReceive) { result in
                
                guard let data = result.data else {
                    InAppNotificationManager.shared.showError(result.errors?.first?.code ?? "API connection error", subtitle: result.errors?.first?.detail)
                    return
                }
                
                UserManager.shared.authorize(access_token: data.attributes.accessToken, expires_in: data.attributes.expiresIn.description, refresh_token: data.attributes.refreshToken)
                
                print("result: \(result)")
                
                onSuccess()
            }
            .store(in: &subscriptions)
    }
    
    private func storeData() {
        print("self.storedEmail: \(self.storedEmail) - self.storedPassword: \(self.storedPassword)")
        
        self.storedEmail = self.emailText.data(using: .utf8)
        self.storedPassword = self.passwordText.data(using: .utf8)
    }
}
