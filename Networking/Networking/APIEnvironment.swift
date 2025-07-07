//
//  APIEnvironment.swift
//  Networking
//
//  Created by slip_def on 07-07-2025.
//

import Foundation

struct APIEnvironment {
    let baseURL: URL
    let additionalHeaders: [HTTPHeaderKey: String]
    
    private init(
        basePath: String,
        additionalHeaders: [HTTPHeaderKey: String] = [:]
    ) {
        self.baseURL = URL(string: basePath)!
        self.additionalHeaders = additionalHeaders
    }
}

// MARK: - Current environment
extension APIEnvironment {
    static func current() -> APIEnvironment {
        APIEnvironment(basePath: AppConfiguration.apiBaseURL)
    }
}
