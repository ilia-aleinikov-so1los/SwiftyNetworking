//
//  HTTPHeaderKey.swift
//  Networking
//
//  Created by slip_def on 07-07-2025.
//

struct HTTPHeaderKey: ExpressibleByStringLiteral, Hashable {
    let rawValue: String
    
    init(stringLiteral value: String) { rawValue = value }
}

// MARK: - Common headers
extension HTTPHeaderKey {
    static let contentType = HTTPHeaderKey("Content-Type")
    static let accept = HTTPHeaderKey("Accept")
    static let authorization = HTTPHeaderKey("Authorization")
    static let userAgent = HTTPHeaderKey("User-Agent")
}
