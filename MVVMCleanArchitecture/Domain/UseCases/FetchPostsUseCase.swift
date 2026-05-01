//
//  FetchPostsUseCase.swift
//  Domain Layer — Use Cases
//
//  Responsible for fetching posts that belong to a specific user.
//  Follows the same single-responsibility principle as FetchUsersUseCase.
//

final class FetchPostsUseCase {

    private let repository: UserRepositoryProtocol

    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }

    // Pass the userId → get back that user's posts
    func execute(for userId: Int) async throws -> [Post] {
        return try await repository.fetchPosts(for: userId)
    }
}
