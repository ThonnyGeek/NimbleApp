//
//  UserManager.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 5/11/23.
//

import Foundation

/*
 @KeyChain(key:  Constants.KEY_IS_AUTHORIZED, account: "NimbleApp") var userisAuthorized
 @KeyChain(key:  Constants.KEY_ACCESS_TOKEN, account: "NimbleApp") var accessToken
 @KeyChain(key:  Constants.KEY_EXPIRES_IN, account: "NimbleApp") var expiresIn
 @KeyChain(key:  Constants.KEY_REFRESH_TOKEN, account: "NimbleApp") var refreshToken
 */
class UserManager: NSObject{
    
    static let shared = UserManager()
    
    var isUserAuthorized: Bool {
        return accessToken != nil
    }
    
    @KeyChain(key:  Constants.KEY_IS_AUTHORIZED, account: "NimbleApp") var userisAuthorizedKC
    @KeyChain(key:  Constants.KEY_ACCESS_TOKEN, account: "NimbleApp") var accessTokenKC
    @KeyChain(key:  Constants.KEY_EXPIRES_IN, account: "NimbleApp") var expiresInKC
    @KeyChain(key:  Constants.KEY_REFRESH_TOKEN, account: "NimbleApp") var refreshTokenKC
    
    private(set) var accessToken: String? {
        set {
            if newValue != nil {
                accessTokenKC = newValue?.data(using: .utf8)
                userisAuthorizedKC = true.description.data(using: .utf8)
            }else{
                accessTokenKC = nil
                userisAuthorizedKC = nil
            }
            UserDefaults.standard.synchronize()
        }
        get {
            guard let accessToken = accessTokenKC, let token = String(data: accessToken, encoding: .utf8) else {
                deleteCredentials()
                return nil
            }
            return token
        }
    }
    
    private(set) var expiresIn: String? {
        set {
            if newValue != nil {
                expiresInKC = newValue?.data(using: .utf8)
            }else{
                expiresInKC = nil
            }
        }
        get {
            guard let expiresInKC = expiresInKC else {
                return nil
            }
            
            return String(data: expiresInKC, encoding: .utf8)
        }
    }
    
    private(set) var refreshToken: String? {
        set {
            if newValue != nil {
                refreshTokenKC = newValue?.data(using: .utf8)
            }else{
                refreshTokenKC = nil
            }
        }
        get {
            guard let refreshTokenKC = refreshTokenKC else {
                return nil
            }
            
            return String(data: refreshTokenKC, encoding: .utf8)
        }
    }
    
    private func deleteCredentials() {
        accessToken = nil
        expiresIn = nil
        refreshToken = nil
    }
    
    func authorize(access_token: String, expires_in: String, refresh_token: String) {
        accessToken = access_token
        expiresIn = expires_in
        refreshToken = refresh_token
    }
    
    func logout() {
        deleteCredentials()
    }
}
