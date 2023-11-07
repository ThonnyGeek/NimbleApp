//
//  HomeRouter.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 6/11/23.
//

import Foundation
import Alamofire

enum HomeRouter: URLRequestConvertible {
    case getSurveys(parameters: Parameters)
    case refreshToken
    case getUserProfile
    
    var path: String {
        switch self {
        case .getSurveys:
            return "/surveys"
        case .refreshToken:
            return "/oauth/token"
        case .getUserProfile:
            return "/me"
        }
    }
    var method: HTTPMethod {
        switch self {
        case .getSurveys, .getUserProfile:
            return .get
        case .refreshToken:
            return .post
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.URLs.production.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        urlRequest.httpMethod = method.rawValue
        
        if let access_token = UserManager().accessToken {
            urlRequest.setValue("Bearer \(access_token)", forHTTPHeaderField: "Authorization")
        }
        
        switch self {
        case .getSurveys(let params):
            print("urlRequest : \(urlRequest)")
            
            urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
        case .getUserProfile:
            return urlRequest
        case .refreshToken:
            
            var params: Parameters = [:]
            
            if let cId = KeyChainHelper.shared.read(key: "client_id", account: Constants.keyAccountName), let cSecret = KeyChainHelper.shared.read(key: "client_secret", account: Constants.keyAccountName), let cIdString = String(data: cId, encoding: .utf8), let cSecretString = String(data: cSecret, encoding: .utf8), let refreshToken = UserManager.shared.refreshToken {
                params.updateValue("refresh_token", forKey: "grant_type")
                params.updateValue(refreshToken, forKey: "refresh_token")
                params.updateValue(cIdString, forKey: "client_id")
                params.updateValue(cSecretString, forKey: "client_secret")
            }
            
            print("parametros: \(params)")
            
            urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
        }
        return urlRequest
    }
}
