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
    @Published final var showLogo = true //false
    @Published final var showLogin = true //false
    @Published var showPasswordRecoveryView = false
    
    
    @Published var emailText: String = ""
    @Published var passwordText: String = ""
    
    
    //MARK: Constants
    
    //MARK: init
    init() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            withAnimation {
//                self.showLogo = true
//            }
//        }
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            withAnimation {
//                self.showLogin = true
//            }
//        }
    }
    
    //MARK: Functions
}
