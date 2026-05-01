//
//  UserRepositoryProtocol.swift
//  Domain Layer — Repository Protocol
//
//  KEY CONCEPT: The Domain layer only defines the contract (protocol).
//  The actual implementation lives in the Data layer.
//
//  Why is this important?
//  → If the API changes tomorrow, only the Data layer changes.
//    The Domain and Presentation layers remain untouched.
//  → In tests, you can inject a MockRepository that returns fake data
//    without making any real network calls.
//  → The Domain layer has no idea where the data comes from —
//    network, database, cache — it simply doesn't care.
//

protocol UserRepositoryProtocol {

    // Fetch all users — async/await, can throw an error on failure
    func fetchUsers() async throws -> [User]

    // Fetch posts for a specific user ID
    func fetchPosts(for userId: Int) async throws -> [Post]
}
