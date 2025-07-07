//
//  NetworkingApp.swift
//  Networking
//
//  Created by slip_def on 07-07-2025.
//

import SwiftUI

@main
struct NetworkingApp: App {
    @State private var viewModel = ViewModel(apiClient: APIClient())
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
