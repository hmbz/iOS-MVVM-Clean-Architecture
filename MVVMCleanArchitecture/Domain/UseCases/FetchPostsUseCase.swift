//
//  FetchPostsUseCase.swift
//  Domain Layer — Use Cases
//

final class FetchPostsUseCase {

    private let repository: UserRepositoryProtocol

    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }

    // userId pass karo → us user ke posts milenge
    func execute(for userId: Int) async throws -> [Post] {
        return try await repository.fetchPosts(for: userId)
    }
}
