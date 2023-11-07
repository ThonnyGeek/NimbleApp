//
//  NimbleAppApp.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 2/11/23.
//

import SwiftUI

@main
struct NimbleAppApp: App {
//    let persistenceController = PersistenceController.shared
    
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    @ObservedObject var welcomeFlowState = WelcomeFlowState()

    var body: some Scene {
        WindowGroup {
            MainView(viewModel: MainViewModel(welcomeFlowState: welcomeFlowState, authService: AuthService()))
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        print("AppDelegate")
        
        @KeyChain(key: "client_id", account: Constants.keyAccountName) var cId
        @KeyChain(key: "client_secret", account: Constants.keyAccountName) var cSecret
        
        cId = "ofzl-2h5ympKa0WqqTzqlVJUiRsxmXQmt5tkgrlWnOE".data(using: .utf8)
        cSecret = "lMQb900L-mTeU-FVTCwyhjsfBwRCxwwbCitPob96cuU".data(using: .utf8)
        
        return true
    }
}
