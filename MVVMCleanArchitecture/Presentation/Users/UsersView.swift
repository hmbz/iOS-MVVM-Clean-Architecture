//
//  UsersView.swift
//  Presentation Layer — View
//
//  KEY CONCEPT: The View has only one responsibility:
//  → Observe the ViewModel's state and render it
//  → Forward user actions to the ViewModel
//
//  The View must NOT contain:
//  ❌ Business logic
//  ❌ Network calls
//  ❌ Data transformation
//

import SwiftUI

struct UsersView: View {

    // @State holds the ViewModel reference.
    // Because ViewModel is @Observable, any property change triggers a re-render.
    @State var viewModel: UsersViewModel

    var body: some View {
        NavigationStack {
            Group {

                // Loading state — show a spinner while data is being fetched
                if viewModel.isLoading {
                    ProgressView("Loading users...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)

                // Error state — show a message and a retry button
                } else if let error = viewModel.errorMessage {
                    errorView(message: error)

                // Success state — render the list of users
                } else {
                    usersList
                }
            }
            .navigationTitle("Users")
            // .task runs when the view appears and is automatically cancelled on disappear
            .task {
                await viewModel.loadUsers()
            }
        }
    }

    // ── Users List ─────────────────────────────────────────────────────────
    var usersList: some View {
        List(viewModel.users, id: \.id) { user in

            // Tapping a row navigates to PostsView for that user.
            // A new PostsViewModel is created with the shared UseCase.
            NavigationLink {
                PostsView(
                    user: user,
                    viewModel: PostsViewModel(fetchPostsUseCase: viewModel.fetchPostsUseCase)
                )
            } label: {
                UserRowView(user: user)
            }
        }
        .listStyle(.insetGrouped)
    }

    // ── Error View ─────────────────────────────────────────────────────────
    func errorView(message: String) -> some View {
        VStack(spacing: 16) {
            Image(systemName: "wifi.exclamationmark")
                .font(.system(size: 50))
                .foregroundStyle(.red)

            Text("Something went wrong")
                .font(.headline)

            Text(message)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            Button("Retry") {
                Task { await viewModel.loadUsers() }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

// ── User Row ───────────────────────────────────────────────────────────────
// Extracted into a separate component — keeps UsersView clean and reusable.
struct UserRowView: View {
    let user: User

    var body: some View {
        HStack(spacing: 12) {

            // Avatar using the first letter of the user's name
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.15))
                    .frame(width: 46, height: 46)

                Text(user.name.prefix(1))
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.blue)
            }

            VStack(alignment: .leading, spacing: 3) {
                Text(user.name)
                    .font(.headline)

                Text(user.email)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text(user.company)
                    .font(.caption)
                    .foregroundStyle(.blue)
            }
        }
        .padding(.vertical, 4)
    }
}
