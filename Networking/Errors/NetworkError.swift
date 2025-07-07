//
//  NetworkError.swift
//  Networking
//
//  Created by slip_def on 07-07-2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL(String)
    case invalidResponse
    
    case requestFailed(HTTPStatusCode, Data?)
    case decodingFailed(DecodingError, Data)
    case encodingFailed(EncodingError)
    
    case apiError(APIError)
    case unknown(Error)
}
