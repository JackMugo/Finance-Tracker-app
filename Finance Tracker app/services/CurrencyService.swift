//
//  CurrencyServiceProtocol.swift
//  Finance Tracker app
//
//  Created by Jackson Mugo on 28/08/2025.
//


import Foundation

protocol CurrencyServiceProtocol {
    func fetchExchangeRates() async throws -> [ExchangeRate]
}

struct CurrencyService: CurrencyServiceProtocol {
    private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    func fetchExchangeRates() async throws -> [ExchangeRate] {
        guard let url = URL(string: "https://tracker.free.beeceptor.com/exchangeRtes") else {
            throw URLError(.badURL)
        }
        return try await apiClient.fetch(url)
    }
}
