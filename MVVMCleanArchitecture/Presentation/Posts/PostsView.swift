//
//  PostsView.swift
//  Presentation Layer — View
//

import SwiftUI

struct PostsView: View {

    let user: User
    @State var viewModel: PostsViewModel

    var body: some View {
        Group {

            // ── Loading ──
            if viewModel.isLoading {
                ProgressView("Loading posts...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

            // ── Error ──
            } else if let error = viewModel.errorMessage {
                VStack(spacing: 12) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.largeTitle)
                        .foregroundStyle(.orange)
                    Text(error)
                        .multilineTextAlignment(.center)
                }
                .padding()

            // ── Empty ──
            } else if viewModel.posts.isEmpty {
                Text("No posts found")
                    .foregroundStyle(.secondary)

            // ── Data ──
            } else {
                postsList
            }
        }
        .navigationTitle("\(user.name)'s Posts")
        .navigationBarTitleDisplayMode(.inline)
        // View appear ho → posts load karo
        .task {
            await viewModel.loadPosts(for: user.id)
        }
    }

    // ── Posts List ─────────────────────────────────────────────────────────
    var postsList: some View {
        List(viewModel.posts, id: \.id) { post in
            VStack(alignment: .leading, spacing: 6) {

                // Post number badge + title
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

                // Post body
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
