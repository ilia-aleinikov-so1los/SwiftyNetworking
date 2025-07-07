//
//  Responses.swift
//  Networking
//
//  Created by slip_def on 07-07-2025.
//

struct User: Decodable {
    let id: Int
    let name: String
    let email: String
}

struct Comment: Decodable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
