//
//  Requests.swift
//  Networking
//
//  Created by slip_def on 07-07-2025.
//

import Foundation

// MARK: - Users
private let pathToUsers = "users/"

struct FetchUserListRequest: Requestable {
    let path = pathToUsers
}

struct FetchUserRequest: Requestable {
    let path: String
    
    init(id: Int) {
        path = pathToUsers + "\(id)"
    }
}

// MARK: - Comments
private let pathToComments = "comments"

struct FetchCommentsRequest: Requestable {
    let path = pathToComments
    let parameters: [URLQueryItem]
    
    init(postId: Int) {
        parameters = [
            URLQueryItem(name: "postId", value: String(postId))
        ]
    }
}

// MARK: - Posts
private let pathToPosts = "posts"

struct UploadPostRequest: Requestable {
    let method = HTTPMethod.POST
    let path = pathToPosts
    let headers: [HTTPHeaderKey : String]
    let body: Post?
    
    init(post: Post) {
        headers = [.contentType: "application/json"]
        body = post
    }
}
