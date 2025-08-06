# Async Networking Demo in SwiftUI

A fully modular, production-ready async/await networking layer in Swift — designed to scale, test, and ship.  
This is the exact implementation described in [this article](#) — rewritten as a real-world demo project.

## Features

- `Requestable` protocol for declarative requests
- `Resource` abstraction to pair requests with response decoding
- `APIClient` with full error handling and status checks
- Environment switching via `.xcconfig` + `Info.plist`
- `HTTPHeaderKey`, `HTTPMethod`, and `HTTPStatusCode` for type safety
- Snake_case JSON decoding and encoding strategy
- SwiftUI + Observation + async ViewModel integration
- Custom error types: `NetworkError`, `APIError`
- Fully testable and ready for production or as a boilerplate

## Architecture

```
Demo Project
├── App
│   ├── Assets
│   ├── Info.plist                    // Injected config values from .xcconfig (e.g. API_BASE_URL)
│   └── NetworkingApp.swift           // App entry point with ViewModel injection
│
├── Configuration
│   ├── AppConfiguration.swift        // Reads config values (like baseURL) from Info.plist at runtime
│   ├── Production.xcconfig           // Production environment variables
│   └── Sandbox.xcconfig              // Sandbox/testing environment variables
│
├── Data
│   ├── BodyModels.swift              // Request body models (e.g. Post)
│   ├── Requests.swift                // Declarative API requests (implementing Requestable)
│   └── Responses.swift               // Response models from backend (e.g. User, Comment)
│
├── Errors
│   ├── APIError.swift                // API-level errors returned in response body
│   └── NetworkError.swift            // Client-side network and decoding/encoding errors
│
├── Extensions
│   ├── JSONDecoderExt.swift          // JSONDecoder with .convertFromSnakeCase strategy
│   ├── JSONEncoderExt.swift          // JSONEncoder with .convertToSnakeCase strategy
│   └── URLRequestExt.swift           // Extension to build URLRequest from any Requestable
│
├── Networking
│   ├── APIClient.swift               // Central executor that performs API calls via URLSession
│   ├── APIEnvironment.swift          // Base URL and shared headers provider
│   ├── Requestable.swift             // Protocol describing structure of any HTTP request
│   └── Resource.swift                // Combines a request with response decoding strategy
│
├── Screens
│   ├── ContentView.swift             // SwiftUI view using async buttons to trigger ViewModel calls
│   └── ViewModel.swift               // Async ViewModel that talks to APIClient and updates UI state
│
└── Type safety
    ├── HTTPMethod.swift              // HTTP method enum (GET, POST, PUT, DELETE)
    ├── HTTPHeaderKey.swift           // Typed HTTP header keys (e.g. .contentType, .authorization)
    └── HTTPStatusCode.swift          // Strongly-typed wrapper around HTTP status codes        
```

## Example usage

Inside `ViewModel.swift`, you can fetch and upload data like this:

```swift
func fetchUserList() async {
    let request = FetchUserListRequest()
    let resource = Resource<[User], FetchUserListRequest>(request: request)
    userList = try await apiClient.dataTask(with: resource)
}

func uploadPost(title: String, body: String) async {
    let post = Post(userId: 1, id: 99, title: title, body: body)
    let request = UploadPostRequest(post: post)
    let resource = Resource<Void, UploadPostRequest>(request: request)
    try await apiClient.dataTask(with: resource)
}
```

## API used

- [https://jsonplaceholder.typicode.com](https://jsonplaceholder.typicode.com)

---
