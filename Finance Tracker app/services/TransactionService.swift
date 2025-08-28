//
//  TransactionServiceProtocol.swift
//  Finance Tracker app
//
//  Created by Jackson Mugo on 28/08/2025.
//


import Foundation

protocol TransactionServiceProtocol {
    func fetchTransactions() async throws -> [Transaction]
}

struct TransactionService: TransactionServiceProtocol {
    private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    func fetchTransactions() async throws -> [Transaction] {
        guard let url = URL(string: "https://tracker.free.beeceptor.com/transactions") else {
            throw URLError(.badURL)
        }
        return try await apiClient.fetch(url)
    }
}
