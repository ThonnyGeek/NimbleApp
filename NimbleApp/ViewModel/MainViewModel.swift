//
//  MainViewModel.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 2/11/23.
//

import SwiftUI
import Combine

final class MainViewModel: ObservableObject {
    
    //MARK: Variables
    @Published final var showLogo = false
    @Published final var showLogin = false
    @Published var showPasswordRecoveryView = false
    
    
    @Published var emailText: String = ""
    @KeyChain(key:  "user_email", account: "NimbleApp") var storedEmail //: String = ""
    
    @Published var passwordText: String = ""
    @KeyChain(key:  "user_password", account: "NimbleApp")  var storedPassword //: String = ""
    
    //MARK: Constants
    
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
    
    func login() {
        storeData()
        
        
    }
    
    private func storeData() {
        print("self.storedEmail: \(self.storedEmail) - self.storedPassword: \(self.storedPassword)")
        
        self.storedEmail = self.emailText.data(using: .utf8)
        self.storedPassword = self.passwordText.data(using: .utf8)
    }
}
