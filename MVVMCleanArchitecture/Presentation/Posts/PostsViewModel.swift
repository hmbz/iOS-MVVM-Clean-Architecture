//
//  PostsViewModel.swift
//  Presentation Layer — ViewModel
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
