//
//  UsersViewModel.swift
//  Presentation Layer — ViewModel
//
//  🔑 KEY CONCEPT: ViewModel ki responsibilities:
//  ✅ UseCase call karna
//  ✅ UI state manage karna (loading, error, data)
//  ✅ View ko inform karna ke kya dikhaaye
//
//  ❌ ViewModel nahi karta:
//  ❌ Network calls directly
//  ❌ UI code (SwiftUI views)
//  ❌ Database access
//

import Foundation

// @Observable → SwiftUI automatically UI update karta hai
// Koi manual objectWillChange.send() nahi chahiye
@Observable
final class UsersViewModel {

    // ── UI State ───────────────────────────────────────────────────────────
    var users: [User] = []          // list me dikhane ke liye users
    var isLoading = false           // loading spinner
    var errorMessage: String?       // error alert message
    var selectedUser: User?         // tap kiya hua user (navigation ke liye)

    // ── Dependencies ───────────────────────────────────────────────────────
    // UseCases inject hote hain — ViewModel ko nahi pata data kahan se aata hai
    private let fetchUsersUseCase: FetchUsersUseCase
    let fetchPostsUseCase: FetchPostsUseCase   // PostsViewModel ko pass karna hai

    init(fetchUsersUseCase: FetchUsersUseCase,
         fetchPostsUseCase: FetchPostsUseCase) {
        self.fetchUsersUseCase = fetchUsersUseCase
        self.fetchPostsUseCase = fetchPostsUseCase
    }

    // ── Actions ────────────────────────────────────────────────────────────

    // View ne .task{ } me yeh call kiya → data fetch karo
    func loadUsers() async {
        isLoading = true
        errorMessage = nil

        do {
            // UseCase call karo — baki sab uska kaam
            users = try await fetchUsersUseCase.execute()
        } catch {
            // Error ko user-friendly message me convert karo
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
