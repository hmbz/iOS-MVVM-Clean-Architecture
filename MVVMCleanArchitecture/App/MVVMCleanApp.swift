//
//  MVVMCleanApp.swift
//  MVVMCleanArchitecture
//

import SwiftUI

@main
struct MVVMCleanApp: App {

    var body: some Scene {
        WindowGroup {

            // Dependency Injection — yahan sab kuch wire karte hain
            // View ko seedha Repository nahi dete — UseCase ke zariye dete hain
            // Is se har layer apni responsibility pe focused rehti hai

            let apiClient    = APIClient()                          // Network
            let repository   = UserRepository(apiClient: apiClient) // Data
            let fetchUsers   = FetchUsersUseCase(repository: repository)  // Domain
            let fetchPosts   = FetchPostsUseCase(repository: repository)  // Domain

            UsersView(
                viewModel: UsersViewModel(fetchUsersUseCase: fetchUsers,
                                          fetchPostsUseCase: fetchPosts)
            )
        }
    }
}
