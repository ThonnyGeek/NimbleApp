//
//  AuthRouter.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 5/11/23.
//

import Foundation
import Alamofire

enum AuthRouter: URLRequestConvertible {
case login(parameters: Parameters)
case passwordRecovery(parameters: Parameters)
    
    var path: String {
        switch self {
        case .login:
            return "/oauth/token"
        case .passwordRecovery:
            return "/passwords"
        }
    }
    var method: HTTPMethod {
        switch self {
        case .login, .passwordRecovery:
            return .post
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.URLs.production.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .login(let params), .passwordRecovery(let params):
            
            var params_with_keys = params
            
            if let cId = KeyChainHelper.shared.read(key: "client_id", account: Constants.keyAccountName), let cSecret = KeyChainHelper.shared.read(key: "client_secret", account: Constants.keyAccountName), let cIdString = String(data: cId, encoding: .utf8), let cSecretString = String(data: cSecret, encoding: .utf8) {
                params_with_keys.updateValue(cIdString, forKey: "client_id")
                params_with_keys.updateValue(cSecretString, forKey: "client_secret")
            }
            
            print("parametros: \(params_with_keys)")
            
            urlRequest = try URLEncoding.default.encode(urlRequest, with: params_with_keys)
        }
        return urlRequest
    }
}
