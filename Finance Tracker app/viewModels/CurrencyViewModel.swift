//
//  CurrencyViewModel.swift
//  Finance Tracker app
//
//  Created by Jackson Mugo on 28/08/2025.
//

import Foundation
import CoreData
import SwiftUI

@MainActor
class CurrencyViewModel: ObservableObject {
    @Published var exchangeRates: [ExchangeRate] = []
    
    private let service: CurrencyServiceProtocol
    private let context: NSManagedObjectContext
    
    init(service: CurrencyServiceProtocol, context: NSManagedObjectContext) {
        self.service = service
        self.context = context
        Task { await loadExchangeRates() }
    }
    
    func loadExchangeRates() async {
        // Step 1: Try fetching from API
        do {
            let apiRates = try await service.fetchExchangeRates()
            self.exchangeRates = apiRates
            await saveToCoreData(rates: apiRates)
            return
        } catch {
            print("❌ API fetch failed: \(error)")
        }
        
        // Step 2: Fallback to Core Data
        let request: NSFetchRequest<ExchangeRateEntity> = ExchangeRateEntity.fetchRequest()
        do {
            let savedRates = try context.fetch(request)
            if !savedRates.isEmpty {
                self.exchangeRates = savedRates.map { entity in
                    ExchangeRate(
                        id: entity.id ?? UUID().uuidString,
                        date: entity.date ?? "",
                        baseCurrency: entity.baseCurrency ?? "",
                        targetCurrency: entity.targetCurrency ?? "",
                        rate: entity.rate,
                        source: entity.source ?? "",
                        status: entity.status ?? ""
                    )
                }
                return
            }
        } catch {
            print("❌ Core Data fetch failed: \(error)")
        }
        
        // Step 3: Fallback to dummy data
        self.exchangeRates = dummyExchangeRates
    }
    
    private func saveToCoreData(rates: [ExchangeRate]) async {
        for rate in rates {
            let request: NSFetchRequest<ExchangeRateEntity> = ExchangeRateEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", rate.id)
            if let count = try? context.count(for: request), count > 0 {
                continue // avoid duplicates
            }
            
            let entity = ExchangeRateEntity(context: context)
            entity.id = rate.id
            entity.date = rate.date
            entity.baseCurrency = rate.baseCurrency
            entity.targetCurrency = rate.targetCurrency
            entity.rate = rate.rate
            entity.source = rate.source
            entity.status = rate.status
        }
        
        do {
            try context.save()
        } catch {
            print("❌ Error saving to Core Data: \(error)")
        }
    }
}



let dummyExchangeRates: [ExchangeRate] = [
    ExchangeRate(id: "1", date: "2025-08-28", baseCurrency: "USD", targetCurrency: "EUR", rate: 0.9145, source: "DummyAPI", status: "success"),
    ExchangeRate(id: "2", date: "2025-08-28", baseCurrency: "USD", targetCurrency: "GBP", rate: 0.7882, source: "DummyAPI", status: "success"),
    ExchangeRate(id: "3", date: "2025-08-28", baseCurrency: "EUR", targetCurrency: "USD", rate: 1.093, source: "DummyAPI", status: "success"),
    ExchangeRate(id: "4", date: "2025-08-28", baseCurrency: "EUR", targetCurrency: "GBP", rate: 0.861, source: "DummyAPI", status: "success"),
    ExchangeRate(id: "5", date: "2025-08-28", baseCurrency: "GBP", targetCurrency: "USD", rate: 1.27, source: "DummyAPI", status: "success"),
    ExchangeRate(id: "6", date: "2025-08-28", baseCurrency: "GBP", targetCurrency: "EUR", rate: 1.16, source: "DummyAPI", status: "success"),
    ExchangeRate(id: "7", date: "2025-08-28", baseCurrency: "USD", targetCurrency: "JPY", rate: 146.0, source: "DummyAPI", status: "success"),
    ExchangeRate(id: "8", date: "2025-08-28", baseCurrency: "EUR", targetCurrency: "JPY", rate: 159.3, source: "DummyAPI", status: "success"),
    ExchangeRate(id: "9", date: "2025-08-28", baseCurrency: "GBP", targetCurrency: "JPY", rate: 184.9, source: "DummyAPI", status: "success"),
    ExchangeRate(id: "10", date: "2025-08-28", baseCurrency: "AUD", targetCurrency: "USD", rate: 0.64, source: "DummyAPI", status: "success"),
    ExchangeRate(id: "11", date: "2025-08-28", baseCurrency: "CAD", targetCurrency: "USD", rate: 0.73, source: "DummyAPI", status: "success"),
    ExchangeRate(id: "12", date: "2025-08-28", baseCurrency: "NZD", targetCurrency: "USD", rate: 0.60, source: "DummyAPI", status: "success"),
    ExchangeRate(id: "13", date: "2025-08-28", baseCurrency: "USD", targetCurrency: "CHF", rate: 0.91, source: "DummyAPI", status: "success"),
    ExchangeRate(id: "14", date: "2025-08-28", baseCurrency: "EUR", targetCurrency: "CHF", rate: 0.99, source: "DummyAPI", status: "success"),
    ExchangeRate(id: "15", date: "2025-08-28", baseCurrency: "GBP", targetCurrency: "CHF", rate: 1.14, source: "DummyAPI", status: "success"),
    ExchangeRate(id: "16", date: "2025-08-28", baseCurrency: "USD", targetCurrency: "CAD", rate: 1.36, source: "DummyAPI", status: "success"),
    ExchangeRate(id: "17", date: "2025-08-28", baseCurrency: "EUR", targetCurrency: "CAD", rate: 1.48, source: "DummyAPI", status: "success"),
    ExchangeRate(id: "18", date: "2025-08-28", baseCurrency: "GBP", targetCurrency: "CAD", rate: 1.72, source: "DummyAPI", status: "success"),
    ExchangeRate(id: "19", date: "2025-08-28", baseCurrency: "USD", targetCurrency: "NZD", rate: 1.66, source: "DummyAPI", status: "success"),
    ExchangeRate(id: "20", date: "2025-08-28", baseCurrency: "EUR", targetCurrency: "NZD", rate: 1.55, source: "DummyAPI", status: "success")
]

