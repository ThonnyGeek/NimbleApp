//
//  NimbleAppApp.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 2/11/23.
//

import SwiftUI

@main
struct NimbleAppApp: App {
    let persistenceController = PersistenceController.shared
    var mainViewModel = MainViewModel()

    var body: some Scene {
        WindowGroup {
            MainView(viewModel: mainViewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear {
                    
//                    guard let emailData = KeyChainHelper.shared.read(key: "user_email", account: "NimbleApp"), let passwordData = KeyChainHelper.shared.read(key: "user_password", account: "NimbleApp") else {
//                        return
//                    }
//                    
//                    print("email: \(String(data: emailData, encoding: .utf8))")
//                    print("password: \(String(data: passwordData, encoding: .utf8))")
                }
        }
    }
}
