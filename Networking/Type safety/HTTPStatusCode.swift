//
//  HTTPStatusCode.swift
//  Networking
//
//  Created by slip_def on 07-07-2025.
//

struct HTTPStatusCode: Decodable, Equatable {
    let value: Int
    
    init(value: Int) {
        self.value = value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.value = try container.decode(Int.self)
    }
}

// MARK: - Common statuses
extension HTTPStatusCode {
    var isSuccess: Bool { (200...299).contains(value) }
    var isClientError: Bool { (400...499).contains(value) }
    var isServerError: Bool { (500...599).contains(value) }
}

// MARK: - Common codes
extension HTTPStatusCode {
    static let ok = HTTPStatusCode(value: 200)
    static let badRequest = HTTPStatusCode(value: 400)
    static let unauthorized = HTTPStatusCode(value: 401)
    static let forbidden = HTTPStatusCode(value: 403)
    static let notFound = HTTPStatusCode(value: 404)
    static let internalServerError = HTTPStatusCode(value: 500)
}
