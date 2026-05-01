//
//  UserDTO.swift
//  Data Layer — Data Transfer Objects (DTOs)
//
//  KEY CONCEPT: DTO vs Entity
//
//  DTO    = the shape of the data as it arrives from the API (JSON keys must match)
//  Entity = the shape of the data as the app uses it internally (clean and minimal)
//
//  Why keep them separate?
//  → The API can change its response structure without breaking the app's business logic.
//  → The Entity only contains the fields the app actually needs.
//  → The Domain layer stays completely independent of the API structure.
//

import Foundation

// Codable = Decodable + Encodable
// Property names must match the JSON keys exactly (or use CodingKeys to remap them)
struct UserDTO: Codable {
    let id: Int
    let name: String
    let email: String
    let phone: String
    let website: String
    let company: CompanyDTO   // nested JSON object

    // Converts the DTO into a Domain Entity.
    // The Data layer always passes Entities to the Domain layer — never raw DTOs.
    func toDomain() -> User {
        User(
            id: id,
            name: name,
            email: email,
            phone: phone,
            website: website,
            company: company.name   // only the name is needed by the app
        )
    }
}

// Represents the nested "company" object that the API returns
struct CompanyDTO: Codable {
    let name: String
    let catchPhrase: String   // present in API response — kept in DTO
    let bs: String            // present in API response — not needed in the Entity
}
