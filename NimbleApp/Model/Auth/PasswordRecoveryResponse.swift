//
//  PasswordRecoveryResponse.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 6/11/23.
//

import Foundation

struct PasswordRecoveryResponse: Decodable {
    var meta: PasswordRecoveryMeta?
    var errors: [ResponseError]?
}

// MARK: - Meta
struct PasswordRecoveryMeta: Decodable {
    var message: String
}
