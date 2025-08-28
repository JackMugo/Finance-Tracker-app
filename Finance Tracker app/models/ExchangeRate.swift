//
//  ExchangeRate.swift
//  Finance Tracker app
//
//  Created by Jackson Mugo on 28/08/2025.
//

import Foundation

struct ExchangeRate: Identifiable, Decodable {
    let id: String
    let date: String
    let baseCurrency: String
    let targetCurrency: String
    let rate: Double
    let source: String
    let status: String
}
