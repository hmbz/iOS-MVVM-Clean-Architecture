//
//  APIClient.swift
//  Data Layer — Network
//
//  Generic network client — koi bhi Decodable type fetch kar sakta hai
//  async/await use kiya hai — modern Swift concurrency
//

import Foundation

// Custom errors — clear error messages
enum APIError: Error, LocalizedError {
    case invalidResponse
    case decodingFailed
    case serverError(Int)

    var errorDescription: String? {
        switch self {
        case .invalidResponse:      return "Invalid server response"
        case .decodingFailed:       return "Failed to decode data"
        case .serverError(let code): return "Server error: \(code)"
        }
    }
}

final class APIClient {

    private let session: URLSession

    // URLSession inject kar sakte hain — testing me mock session de sakte hain
    init(session: URLSession = .shared) {
        self.session = session
    }

    // Generic fetch function — T koi bhi Decodable type ho sakta hai
    // Usage: try await client.fetch([UserDTO].self, from: url)
    func fetch<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T {

        // 1. Network request karo
        let (data, response) = try await session.data(from: url)

        // 2. HTTP response check karo
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        // 3. Status code check karo — 200...299 success range
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.serverError(httpResponse.statusCode)
        }

        // 4. JSON decode karo
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.decodingFailed
        }
    }
}
