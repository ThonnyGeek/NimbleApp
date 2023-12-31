//
//  LoginResponse.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 5/11/23.
//

import Foundation

struct LoginResponse: Decodable {
    var data: LoginData?
    var errors: [ResponseError]?
}

// MARK: - DataClass
struct LoginData: Decodable {
    var id, type: String
    var attributes: LoginDataAttributes
}

// MARK: - Attributes
struct LoginDataAttributes: Decodable {
    var accessToken, tokenType: String
    var expiresIn: Int
    var refreshToken: String
    var createdAt: Int

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case createdAt = "created_at"
    }
}

// MARK: - Error
struct ResponseError: Decodable {
    var detail: String
    var code: String?
}
