//
//  JSONEncoderExt.swift
//  Networking
//
//  Created by slip_def on 07-07-2025.
//

import Foundation

extension JSONEncoder {
    static var snakeCaseConverting: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
}
