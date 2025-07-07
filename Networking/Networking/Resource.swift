//
//  Resource.swift
//  Networking
//
//  Created by slip_def on 07-07-2025.
//

import Foundation

struct Resource<Response, Request: Requestable> {
    let request: Request
    let decode: (Data) throws -> Response
}

// MARK: - Normal response
extension Resource where Response: Decodable {
    init(request: Request) {
        self.init(request: request) { data in
            do {
                return try JSONDecoder.snakeCaseConverting.decode(
                    Response.self,
                    from: data
                )
            } catch {
                throw error
            }
        }
    }
}

// MARK: - Empty response
extension Resource where Response == Void {
    init(request: Request) {
        self.init(request: request) { _ in return () }
    }
}
