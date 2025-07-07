//
//  JSONDecoderExt.swift
//  Networking
//
//  Created by slip_def on 07-07-2025.
//

import Foundation

extension JSONDecoder {
    static var snakeCaseConverting: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
