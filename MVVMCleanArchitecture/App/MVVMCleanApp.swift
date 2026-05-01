//
//  MVVMCleanApp.swift
//  MVVMCleanArchitecture
//

import SwiftUI

@main
struct MVVMCleanApp: App {

    var body: some Scene {
        WindowGroup {

            // Dependency Injection — all dependencies are wired here at the app level.
            // The View never directly touches the Repository.
            // Everything flows through the UseCase — keeping each layer independent.

            let apiClient  = APIClient()                                // Network layer
            let repository = UserRepository(apiClient: apiClient)       // Data layer
            let fetchUsers = FetchUsersUseCase(repository: repository)  // Domain layer
            let fetchPosts = FetchPostsUseCase(repository: repository)  // Domain layer

            UsersView(
                viewModel: UsersViewModel(
                    fetchUsersUseCase: fetchUsers,
                    fetchPostsUseCase: fetchPosts
                )
            )
        }
    }
}
