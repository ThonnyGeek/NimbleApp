//
//  AuthService.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 5/11/23.
//

import Foundation
import Combine
import Alamofire

protocol AuthServiceProtocol {
    func login(params: Parameters) -> AnyPublisher<LoginResponse, Never>
    func passwordRecovery(email: String) -> AnyPublisher<PasswordRecoveryResponse, Never>
}

class AuthService: AuthServiceProtocol {
    func login(params: Parameters) -> AnyPublisher<LoginResponse, Never> {
        return AF.request(AuthRouter.login(parameters: params))
            .publishDecodable(type: LoginResponse.self)
            .compactMap { result in
                guard let result = result.value else {
                    print("ERROR FATAL: \(String(describing: result.error))")
                    return nil
                }
                return result
            }
            .eraseToAnyPublisher()
    }
    
    func passwordRecovery(email: String) -> AnyPublisher<PasswordRecoveryResponse, Never> {
        
        let params: Parameters = [
            "user" : [
                "email" : email
            ]
        ]
        
        return AF.request(AuthRouter.passwordRecovery(parameters: params))
            .publishDecodable(type: PasswordRecoveryResponse.self)
            .compactMap { result in
                guard let result = result.value else {
                    //                    fatalError("ERROR FATAL: \(result.error)")
                    return nil
                }
                return result
            }
            .eraseToAnyPublisher()
    }
}
