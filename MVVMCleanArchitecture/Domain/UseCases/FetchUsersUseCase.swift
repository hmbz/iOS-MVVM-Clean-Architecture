//
//  FetchUsersUseCase.swift
//  Domain Layer — Use Cases
//
//  KEY CONCEPT: One UseCase = One job.
//  This UseCase only does one thing: "fetch and return sorted users".
//
//  Benefits of Use Cases:
//  → Business logic lives here, not in the ViewModel or Repository.
//  → The ViewModel simply calls execute() — it doesn't care about the details.
//  → Extremely easy to unit test in isolation.
//  → If the sorting rule changes, you update only this file.
//

final class FetchUsersUseCase {

    // Depend on the protocol, not the concrete class.
    // This allows injecting a MockRepository during testing.
    private let repository: UserRepositoryProtocol

    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }

    // execute() — the single entry point for this use case.
    // Business rule applied here: sort users alphabetically by name.
    func execute() async throws -> [User] {
        let users = try await repository.fetchUsers()
        return users.sorted { $0.name < $1.name }  // Business rule: A → Z
    }
}
