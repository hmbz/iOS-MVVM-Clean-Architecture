//
//  UserRepositoryProtocol.swift
//  Domain Layer — Repository Protocol
//
//  🔑 KEY CONCEPT: Domain layer sirf Protocol define karta hai
//  Actual implementation Data layer me hoti hai
//
//  Iska faida:
//  → Kal API change ho jaye → sirf Data layer badlo, Domain/Presentation same rahega
//  → Testing me fake (mock) repository inject kar sakte ho
//  → Domain layer ko pata hi nahi ke data kahan se aa raha hai
//

protocol UserRepositoryProtocol {

    // Users fetch karo — async/await se, error throw kar sakta hai
    func fetchUsers() async throws -> [User]

    // Specific user ke posts fetch karo
    func fetchPosts(for userId: Int) async throws -> [Post]
}
