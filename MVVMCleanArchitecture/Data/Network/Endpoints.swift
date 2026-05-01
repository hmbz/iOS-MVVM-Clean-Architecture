//
//  Endpoints.swift
//  Data Layer — Network
//
//  All API endpoint URLs are defined in one place.
//  If the base URL or a path changes, there is only one file to update.
//

import Foundation

enum Endpoints {

    static let baseURL = "https://jsonplaceholder.typicode.com"

    // GET /users — returns all users
    static var users: URL {
        URL(string: "\(baseURL)/users")!
    }

    // GET /posts?userId=1 — returns all posts for a given user
    static func posts(for userId: Int) -> URL {
        URL(string: "\(baseURL)/posts?userId=\(userId)")!
    }
}
