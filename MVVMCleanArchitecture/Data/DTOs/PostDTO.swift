//
//  PostDTO.swift
//  Data Layer — Data Transfer Objects
//
//  Represents the raw post object returned by the API.
//  Converted to a Domain Entity before being passed up to the Domain layer.
//
struct PostDTO: Codable {
    let id: Int
    let userId: Int
    let title: String
    let body: String

    // Convert raw API data into a clean Domain Entity
    func toDomain() -> Post {
        Post(id: id, userId: userId, title: title, body: body)
    }
}
