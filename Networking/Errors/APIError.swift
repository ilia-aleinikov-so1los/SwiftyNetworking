//
//  APIError.swift
//  Networking
//
//  Created by slip_def on 07-07-2025.
//

import Foundation

struct APIError: Decodable, Error {
    let errorCode: HTTPStatusCode
    let error: String
    let errors: [String]
}

// MARK: --
extension APIError: LocalizedError {
    var errorDescription: String? {
        NSLocalizedString("error.\(errorCode.value)", comment: "")
    }
}
