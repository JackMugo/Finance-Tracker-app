//
//  CurrencyViewModel.swift
//  Finance Tracker app
//
//  Created by Jackson Mugo on 28/08/2025.
//


import Foundation

@MainActor
class CurrencyViewModel: ObservableObject {
    @Published var exchangeRates: [ExchangeRate] = []
    private let service: CurrencyServiceProtocol

    init(service: CurrencyServiceProtocol) {
        self.service = service
    }

    func loadExchangeRates() async {
        do {
            let result = try await service.fetchExchangeRates()
            self.exchangeRates = result
        } catch {
            print("❌ Error fetching exchange rates: \(error)")
        }
    }
}
