//
//  APIClient.swift
//  Finance Tracker app
//
//  Created by Jackson Mugo on 28/08/2025.
//


import Foundation

protocol APIClientProtocol {
    func fetch<T: Decodable>(_ url: URL) async throws -> T
}

struct APIClient: APIClientProtocol {
    func fetch<T: Decodable>(_ url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
