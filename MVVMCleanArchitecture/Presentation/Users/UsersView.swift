//
//  UsersView.swift
//  Presentation Layer — View
//
//  🔑 KEY CONCEPT: View ki sirf ek responsibility hai
//  → ViewModel ka state dekho aur dikhaao
//  → User action ho → ViewModel ko batao
//  → Koi business logic nahi, koi network call nahi
//

import SwiftUI

struct UsersView: View {

    // @State → ViewModel ka reference
    // @Observable ki wajah se changes automatically reflect honge
    @State var viewModel: UsersViewModel

    var body: some View {
        NavigationStack {
            Group {

                // ── Loading State ──
                if viewModel.isLoading {
                    ProgressView("Loading users...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)

                // ── Error State ──
                } else if let error = viewModel.errorMessage {
                    errorView(message: error)

                // ── Data State ──
                } else {
                    usersList
                }
            }
            .navigationTitle("Users")
            // View appear ho → ViewModel ko data load karne kaho
            .task {
                await viewModel.loadUsers()
            }
        }
    }

    // ── Users List ─────────────────────────────────────────────────────────
    var usersList: some View {
        List(viewModel.users, id: \.id) { user in

            // NavigationLink → tap karo → PostsView khule
            NavigationLink {
                // PostsViewModel banao aur inject karo
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
// Alag component — reusable, clean
struct UserRowView: View {
    let user: User

    var body: some View {
        HStack(spacing: 12) {

            // Avatar — initials se
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.15))
                    .frame(width: 46, height: 46)

                Text(user.name.prefix(1))  // pehla letter
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
