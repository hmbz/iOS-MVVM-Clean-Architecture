//
//  UserRepository.swift
//  Data Layer — Repository Implementation
//
//  KEY CONCEPT:
//  The Domain layer defined the contract (UserRepositoryProtocol).
//  This class is the concrete implementation of that contract.
//
//  Full data flow:
//  ViewModel → UseCase → Protocol → [this file] → APIClient → URLSession → Network
//
//  The layers above this file only see the protocol — they never know
//  this concrete class exists. That is exactly the point.
//

final class UserRepository: UserRepositoryProtocol {

    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    // Implementation of the first protocol requirement
    func fetchUsers() async throws -> [User] {

        // Step 1: Fetch raw DTOs from the network
        let dtos = try await apiClient.fetch([UserDTO].self, from: Endpoints.users)

        // Step 2: Map each DTO into a Domain Entity
        // The Domain layer receives [User] — it never sees [UserDTO]
        return dtos.map { $0.toDomain() }
    }

    // Implementation of the second protocol requirement
    func fetchPosts(for userId: Int) async throws -> [Post] {
        let dtos = try await apiClient.fetch([PostDTO].self, from: Endpoints.posts(for: userId))
        return dtos.map { $0.toDomain() }
    }
}
