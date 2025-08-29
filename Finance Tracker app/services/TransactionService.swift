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

class TransactionService: TransactionServiceProtocol {
    func fetchTransactions() async throws -> [Transaction] {
        guard let url = URL(string: "https://tracker.free.beeceptor.com/transactions") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let transactions = try JSONDecoder().decode([Transaction].self, from: data)
        return transactions
    }
}

