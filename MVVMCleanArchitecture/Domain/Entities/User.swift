//
//  User.swift
//  Domain Layer — Entities
//
//  ⚠️ IMPORTANT: Domain layer me KOI bhi import nahi hota
//  Nah SwiftUI, nah Foundation — pure Swift structs
//  Yahi Clean Architecture ki pehli rule hai
//

// Entity = App ki core business object
// Yeh sirf data hold karta hai — koi logic nahi, koi framework nahi
struct User {
    let id: Int
    let name: String
    let email: String
    let phone: String
    let website: String
    let company: String   // company ka naam
}
