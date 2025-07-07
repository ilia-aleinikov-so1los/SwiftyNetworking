//
//  Requestable.swift
//  Networking
//
//  Created by slip_def on 07-07-2025.
//

import Foundation

protocol Requestable {
    associatedtype Body: Encodable = Never
    var method: HTTPMethod { get }
    
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    
    var headers: [HTTPHeaderKey: String] { get }
    var body: Body? { get }
}

// MARK: - Default implementation
extension Requestable {
    var method: HTTPMethod { .GET }
    var parameters: [URLQueryItem] { [] }
    
    var headers: [HTTPHeaderKey: String] { [:] }
    var body: Never? { nil }
}

// MARK: - Full URL
extension Requestable {
    func fullURL(baseURL: URL) -> URL? {
        guard let url = URL(
                string: path, relativeTo: baseURL
              ),
              var urlComponents = URLComponents(
                url: url, resolvingAgainstBaseURL: true
              )
        else { return nil }
        
        if !parameters.isEmpty { urlComponents.queryItems = parameters }
        return urlComponents.url
    }
}
