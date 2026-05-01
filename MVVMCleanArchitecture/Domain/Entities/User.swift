//
//  User.swift
//  Domain Layer — Entities
//
//  IMPORTANT: The Domain layer has NO imports — not even Foundation.
//  It contains pure Swift structs only.
//  This is the first rule of Clean Architecture:
//  the innermost layer must have zero external dependencies.
//

// Entity = the core business object of the app.
// It only holds data — no logic, no frameworks, no network awareness.
// This struct represents a User as the app understands it (not how the API sends it).
struct User {
    let id: Int
    let name: String
    let email: String
    let phone: String
    let website: String
    let company: String   // only the company name — not the full API nested object
}
