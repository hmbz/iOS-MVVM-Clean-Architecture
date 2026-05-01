//
//  Endpoints.swift
//  Data Layer — Network
//
//  Saare API endpoints ek jagah — easy to manage
//

import Foundation

enum Endpoints {

    static let baseURL = "https://jsonplaceholder.typicode.com"

    // /users → saare users
    static var users: URL {
        URL(string: "\(baseURL)/users")!
    }

    // /posts?userId=1 → us user ke posts
    static func posts(for userId: Int) -> URL {
        URL(string: "\(baseURL)/posts?userId=\(userId)")!
    }
}
