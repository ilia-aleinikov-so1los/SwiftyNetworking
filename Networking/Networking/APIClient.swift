//
//  APIClient.swift
//  Networking
//
//  Created by slip_def on 07-07-2025.
//

import Foundation

final class APIClient {
    private let environment: APIEnvironment
    private let urlSession: URLSession
    
    init(
        environment: APIEnvironment = .current(),
        urlSession: URLSession = .shared
    ) {
        self.environment = environment
        self.urlSession = urlSession
    }
}

// MARK: - Data task
extension APIClient {
    func dataTask<Response, Request>(
        with resource: Resource<Response, Request>
    ) async throws -> Response {
        let urlRequest = try URLRequest(
            request: resource.request,
            baseURL: environment.baseURL,
            additionalHeaders: environment.additionalHeaders
        )
        
        // Downcasting to HTTPURLResponse
        let (data, response) = try await urlSession.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        // Checking the request status
        let statusCode = HTTPStatusCode(value: httpResponse.statusCode)
        
        guard statusCode.isSuccess else {
            if let apiError = try? JSONDecoder.snakeCaseConverting.decode(
                APIError.self, from: data
            ) {
                throw NetworkError.apiError(apiError)
            }
            
            throw NetworkError.requestFailed(statusCode, data)
        }
        
        // Decoding
        do {
            return try resource.decode(data)
        } catch let decodingError as DecodingError {
            throw NetworkError.decodingFailed(decodingError, data)
        } catch {
            throw NetworkError.unknown(error)
        }
    }
}
