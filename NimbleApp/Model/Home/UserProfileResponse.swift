//
//  UserProfileResponse.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 6/11/23.
//

import Foundation

struct UserProfileResponse: Decodable {
    var data: UserProfileData?
    var errors: [ResponseError]?
}

// MARK: - DataClass
struct UserProfileData: Decodable {
    var id, type: String
    var attributes: UserProfileAttributes
}

// MARK: - Attributes
struct UserProfileAttributes: Decodable {
    var email, name: String
    var avatarURL: String

    enum CodingKeys: String, CodingKey {
        case email, name
        case avatarURL = "avatar_url"
    }
}
