//
//  Constans.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 2/11/23.
//

import SwiftUI
import Combine

struct Constants {
    struct URLs {
        static let Production     = "https://survey-api.nimblehq.co"
        static let Staging        = "https://nimble-survey-web-staging.herokuapp.com"
    }
    
    struct Sizes {
        static let width = UIScreen.main.bounds.width
        static let height = UIScreen.main.bounds.height
    }
    
    static let keyAccountName: String = "NimbleApp"
    static let KEY_IS_AUTHORIZED: String = "KEY_IS_AUTHORIZED"
    static let KEY_ACCESS_TOKEN: String = "KEY_ACCESS_TOKEN"
    static let KEY_EXPIRES_IN: String = "KEY_EXPIRES_IN"
    static let KEY_REFRESH_TOKEN: String = "KEY_REFRESH_TOKEN"
    
    // Receiver from URLSession
    static func onReceive(_ completion: Subscribers.Completion<Never>) {
        switch completion {
        case .finished:
            print("Finished")
        case .failure(let error):
            //            fatalError(error.localizedDescription)
            print("URLSession ERROR: \(error.localizedDescription)")
        }
    }
}
