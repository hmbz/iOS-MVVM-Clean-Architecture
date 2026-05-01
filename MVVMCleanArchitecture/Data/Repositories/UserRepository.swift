//
//  UserRepository.swift
//  Data Layer — Repository Implementation
//
//  🔑 KEY CONCEPT:
//  Domain layer ne Protocol define kiya tha
//  Data layer uska actual implementation karta hai
//
//  Flow:
//  ViewModel → UseCase → Protocol → [Repository impl here] → APIClient → Network
//

final class UserRepository: UserRepositoryProtocol {

    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    // Protocol ka first function implement karo
    func fetchUsers() async throws -> [User] {

        // 1. API se DTO fetch karo
        let dtos = try await apiClient.fetch([UserDTO].self, from: Endpoints.users)

        // 2. DTOs ko Domain Entities me convert karo
        // .map → har DTO ke liye toDomain() call karo
        return dtos.map { $0.toDomain() }

        // Domain layer ko DTO ka kuch pata nahi — sirf User entity milti hai ✅
    }

    // Protocol ka second function implement karo
    func fetchPosts(for userId: Int) async throws -> [Post] {
        let dtos = try await apiClient.fetch([PostDTO].self, from: Endpoints.posts(for: userId))
        return dtos.map { $0.toDomain() }
    }
}
