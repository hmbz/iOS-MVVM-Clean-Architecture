//
//  PostDTO.swift
//  Data Layer — DTOs
//

struct PostDTO: Codable {
    let id: Int
    let userId: Int
    let title: String
    let body: String

    // DTO → Domain Entity
    func toDomain() -> Post {
        Post(id: id, userId: userId, title: title, body: body)
    }
}
