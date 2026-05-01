//
//  FetchUsersUseCase.swift
//  Domain Layer — Use Cases
//
//  🔑 KEY CONCEPT: UseCase = ek kaam, ek responsibility
//  "Users fetch karo" — bas itna
//
//  UseCase ke fayde:
//  → Business logic yahan hoti hai (filtering, sorting, validation)
//  → ViewModel sirf UseCase call karta hai — baki sab hide hai
//  → Testing bohat easy ho jaati hai
//

final class FetchUsersUseCase {

    // Protocol use karte hain — concrete class nahi
    // Is se testing me MockRepository inject kar sakte hain
    private let repository: UserRepositoryProtocol

    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }

    // execute() — UseCase ka main function
    // Business logic yahan hoti hai
    // Abhi simple hai — sirf fetch karo aur name se sort karo
    func execute() async throws -> [User] {
        let users = try await repository.fetchUsers()
        return users.sorted { $0.name < $1.name }  // ← Business rule: alphabetically sort
    }
}
