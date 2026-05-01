//
//  UserDTO.swift
//  Data Layer — DTOs (Data Transfer Objects)
//
//  🔑 KEY CONCEPT: DTO vs Entity
//
//  DTO  = API se jo aata hai woh shape (JSON keys match karte hain)
//  Entity = App ke andar jo use hota hai (clean, simple)
//
//  Kyon alag?
//  → API kal change ho jaye → sirf DTO badlo, Entity same rahe
//  → Entity me sirf woh data jo app ko chahiye
//  → Domain layer API structure se independent rahe
//

import Foundation

// Codable = Decodable + Encodable
// JSON keys exactly match karne chahiye (ya CodingKeys use karo)
struct UserDTO: Codable {
    let id: Int
    let name: String
    let email: String
    let phone: String
    let website: String
    let company: CompanyDTO  // nested object

    // DTO → Entity conversion
    // Data layer Domain layer ko DTO nahi deta — Entity deta hai
    func toDomain() -> User {
        User(
            id: id,
            name: name,
            email: email,
            phone: phone,
            website: website,
            company: company.name  // sirf name chahiye
        )
    }
}

// Nested company object — API me aisa aata hai
struct CompanyDTO: Codable {
    let name: String
    let catchPhrase: String  // API me hai — DTO me rakhte hain
    let bs: String           // API me hai — Entity me nahi chahiye
}
