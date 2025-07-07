//
//  AppConfiguration.swift
//  Networking
//
//  Created by slip_def on 07-07-2025.
//

import Foundation

// MARK: - Keys
extension AppConfiguration {
    enum Keys: String {
        case baseURL = "API_BASE_URL"
    }
}

// MARK: - Common values
struct AppConfiguration {
    static var apiBaseURL: String {
        stringBy(.baseURL).replacingOccurrences(of: "\\", with: "")
    }
}

// MARK: - The method of searching for the value of the info dictionary by the key
private extension AppConfiguration {
    static func stringBy(_ key: Keys) -> String {
        guard let dict = Bundle.main.infoDictionary
        else { fatalError("Plist file not found" ) }
        
        guard let value = dict[key.rawValue] as? String
        else { fatalError("Key `\(key.rawValue)` not set in plist") }
        
        return value
    }
}
