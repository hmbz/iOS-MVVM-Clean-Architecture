//
//  Post.swift
//  Domain Layer — Entities
//
//  A Post entity represents a single post belonging to a User.
//  Pure Swift struct — no external dependencies.
//
struct Post {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
