//
//  ContentView.swift
//  Networking
//
//  Created by slip_def on 07-07-2025.
//

import SwiftUI

struct ContentView: View {
    @Bindable private(set) var viewModel: ViewModel
    
    var body: some View {
        resultsList
            .safeAreaInset(edge: .top) { topBar }
            .safeAreaInset(edge: .bottom) { bottomBar }
    }
}

// MARK: - Results
private extension ContentView {
    var resultsList: some View {
        List {
            Section("Results") {
                makeRow("First user from list:", content: "\(viewModel.userList.first)")
                makeRow("User fetched by id:", content: "\(viewModel.user)")
                makeRow("Comments:", content: "\(viewModel.comments)")
                makeRow("Post body:", content: viewModel.postBody)
            }
        }.listStyle(.insetGrouped)
    }
    
    func makeRow(_ title: String, content: String) -> some View {
        VStack(alignment: .leading) {
            makeRainbowText(title)
            Text(content).foregroundStyle(.secondary)
        }
    }
}

// MARK: - Bottom bar
private extension ContentView {
    var topBar: some View {
        Text("Networking")
            .font(.title)
            .frame(maxWidth: .infinity)
            .padding()
            .background(.ultraThinMaterial)
    }
}

// MARK: - Bottom bar
private extension ContentView {
    var bottomBar: some View {
        VStack {
            makeTintedButton(title: "Fetch user list") {
                await viewModel.fetchUserList()
            }
            
            makeTintedButton(title: "Fetch user by id") {
                await viewModel.fetchUserBy(id: 1)
            }
            
            makeTintedButton(title: "Fetch comments") {
                await viewModel.fetchCommentsByPost(id: 1)
            }
            
            makeTintedButton(title: "Upload post") {
                await viewModel.uploadPost(
                    withTitle: "Greetings",
                    andBody: "Hello there :-)"
                )
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.ultraThinMaterial)
    }
}

// MARK: --
// MARK: - Custom text
private extension ContentView {
    func makeRainbowText(_ title: String) -> some View {
        Text(title)
            .font(.headline)
            .foregroundStyle(
                LinearGradient(
                    colors: [.red, .orange, .yellow, .green, .blue, .indigo, .purple],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
    }
}

// MARK: - Custom button
private extension ContentView {
    func makeTintedButton(
        title: String,
        action: @escaping () async -> Void
    ) -> some View {
        Button {
            Task { await action() }
        } label: {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity)
        }.buttonStyle(.borderedProminent)
    }
}
