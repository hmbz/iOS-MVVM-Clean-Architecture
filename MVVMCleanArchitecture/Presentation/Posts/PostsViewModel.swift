//
//  PostsViewModel.swift
//  Presentation Layer — ViewModel
//
//  Follows the exact same pattern as UsersViewModel.
//  Each screen has its own dedicated ViewModel — single responsibility.
//

import Foundation

@Observable
final class PostsViewModel {

    // ── UI State ───────────────────────────────────────────────────────────
    var posts: [Post] = []
    var isLoading = false
    var errorMessage: String?

    // ── Dependencies ───────────────────────────────────────────────────────
    private let fetchPostsUseCase: FetchPostsUseCase

    init(fetchPostsUseCase: FetchPostsUseCase) {
        self.fetchPostsUseCase = fetchPostsUseCase
    }

    // ── Actions ────────────────────────────────────────────────────────────

    // Called by PostsView when it appears on screen.
    // Fetches posts for the given userId.
    func loadPosts(for userId: Int) async {
        isLoading = true
        errorMessage = nil

        do {
            posts = try await fetchPostsUseCase.execute(for: userId)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
