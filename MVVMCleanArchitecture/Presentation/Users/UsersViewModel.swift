//
//  UsersViewModel.swift
//  Presentation Layer — ViewModel
//
//  KEY CONCEPT: The ViewModel has three responsibilities:
//  ✅ Call the UseCase to fetch data
//  ✅ Manage UI state (loading, error, success)
//  ✅ Expose that state to the View
//
//  The ViewModel must NOT:
//  ❌ Make network calls directly
//  ❌ Contain any SwiftUI view code
//  ❌ Access the database or APIClient directly
//

import Foundation

// @Observable — SwiftUI automatically re-renders the View
// when any stored property changes. No manual sink or objectWillChange needed.
@Observable
final class UsersViewModel {

    // ── UI State ───────────────────────────────────────────────────────────
    var users: [User] = []          // the list of users shown in the View
    var isLoading = false           // controls the loading spinner
    var errorMessage: String?       // non-nil when an error occurs

    // ── Dependencies ───────────────────────────────────────────────────────
    // The ViewModel receives UseCases — it has no knowledge of the Repository or APIClient.
    private let fetchUsersUseCase: FetchUsersUseCase
    let fetchPostsUseCase: FetchPostsUseCase   // passed through to PostsViewModel on navigation

    init(fetchUsersUseCase: FetchUsersUseCase,
         fetchPostsUseCase: FetchPostsUseCase) {
        self.fetchUsersUseCase = fetchUsersUseCase
        self.fetchPostsUseCase = fetchPostsUseCase
    }

    // ── Actions ────────────────────────────────────────────────────────────

    // Called by the View inside .task{ } when the screen appears.
    // Calls the UseCase — everything else is handled internally.
    func loadUsers() async {
        isLoading = true
        errorMessage = nil

        do {
            users = try await fetchUsersUseCase.execute()
        } catch {
            // Convert the technical error into a user-readable message
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
