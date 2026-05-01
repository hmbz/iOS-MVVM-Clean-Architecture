//
//  PostsView.swift
//  Presentation Layer — View
//
//  Displays all posts belonging to a selected User.
//  Follows the same state-driven rendering pattern as UsersView.
//

import SwiftUI

struct PostsView: View {

    let user: User                   // the selected user passed from UsersView
    @State var viewModel: PostsViewModel

    var body: some View {
        Group {

            // Loading state
            if viewModel.isLoading {
                ProgressView("Loading posts...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Error state
            } else if let error = viewModel.errorMessage {
                VStack(spacing: 12) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.largeTitle)
                        .foregroundStyle(.orange)
                    Text(error)
                        .multilineTextAlignment(.center)
                }
                .padding()

            // Empty state — user exists but has no posts
            } else if viewModel.posts.isEmpty {
                Text("No posts found for this user.")
                    .foregroundStyle(.secondary)

            // Success state — render the posts list
            } else {
                postsList
            }
        }
        .navigationTitle("\(user.name)'s Posts")
        .navigationBarTitleDisplayMode(.inline)
        // Fetch posts when this screen appears, using the selected user's ID
        .task {
            await viewModel.loadPosts(for: user.id)
        }
    }

    // ── Posts List ─────────────────────────────────────────────────────────
    var postsList: some View {
        List(viewModel.posts, id: \.id) { post in
            VStack(alignment: .leading, spacing: 6) {

                // Post number badge alongside the title
                HStack(alignment: .top, spacing: 8) {
                    Text("#\(post.id)")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.blue)
                        .clipShape(Capsule())

                    Text(post.title.capitalized)
                        .font(.headline)
                        .lineLimit(2)
                }

                // Post body — truncated to 3 lines in the list
                Text(post.body)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)
            }
            .padding(.vertical, 4)
        }
        .listStyle(.insetGrouped)
    }
}
