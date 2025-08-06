//
//  ViewModel.swift
//  Networking
//
//  Created by slip_def on 07-07-2025.
//

import Observation

@Observable
final class ViewModel {
    private(set) var userList: [User] = []
    private(set) var user: User?
    private(set) var comments: [Comment] = []
    private(set) var postBody = ""
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
}

// MARK: - Users
extension ViewModel {
    func fetchUserList() async {
        do {
            let request = FetchUserListRequest()
            let resource = Resource<[User], FetchUserListRequest>(request: request)
            
            let response = try await apiClient.dataTask(with: resource)
            userList = response
        } catch {
            dump(error)
        }
    }
    
    func fetchUserBy(id userId: Int) async {
        do {
            let request = FetchUserRequest(id: userId)
            let resource = Resource<User, FetchUserRequest>(request: request)
            
            let response = try await apiClient.dataTask(with: resource)
            user = response
        } catch {
            dump(error)
        }
    }
}

// MARK: - Comments
extension ViewModel {
    func fetchCommentsByPost(id postId: Int) async {
        do {
            let request = FetchCommentsRequest(postId: postId)
            let resource = Resource<[Comment], FetchCommentsRequest>(request: request)
            
            let response = try await apiClient.dataTask(with: resource)
            comments = response
        } catch {
            dump(error)
        }
    }
}

// MARK: - Posts
extension ViewModel {
    func uploadPost(withTitle title: String, andBody body: String) async {
        guard let user else {
            postBody = "Fetch user first"
            return
        }
        
        do {
            let post = Post(userId: user.id, id: 1, title: title, body: body)
            let request = UploadPostRequest(post: post)
            let resource = Resource<Void, UploadPostRequest>(request: request)
            
            let _ = try await apiClient.dataTask(with: resource)
            postBody = post.body
        } catch {
            dump(error)
        }
    }
}
