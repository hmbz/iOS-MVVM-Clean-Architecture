//
//  APIClient.swift
//  Data Layer — Network
//
//  A generic, reusable network client.
//  Uses async/await — the modern Swift concurrency model.
//  Can fetch any Decodable type from any URL.
//

import Foundation

// Strongly typed error cases — clear and descriptive
enum APIError: Error, LocalizedError {
    case invalidResponse          // response was not a valid HTTP response
    case decodingFailed           // JSON could not be decoded into the expected type
    case serverError(Int)         // server returned a non-2xx status code

    var errorDescription: String? {
        switch self {
        case .invalidResponse:         return "Invalid server response."
        case .decodingFailed:          return "Failed to decode the response data."
        case .serverError(let code):   return "Server returned error code \(code)."
        }
    }
}

final class APIClient {

    private let session: URLSession

    // URLSession is injected — allows passing a mock session in unit tests
    init(session: URLSession = .shared) {
        self.session = session
    }

    // Generic fetch method — T can be any Decodable type
    // Example: try await client.fetch([UserDTO].self, from: url)
    func fetch<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T {

        // Step 1: Make the network request
        let (data, response) = try await session.data(from: url)

        // Step 2: Validate it is an HTTP response
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        // Step 3: Check for a successful status code (200–299)
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.serverError(httpResponse.statusCode)
        }

        // Step 4: Decode JSON into the requested type
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.decodingFailed
        }
    }
}
