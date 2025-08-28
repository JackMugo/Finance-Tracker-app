//
//  Transaction.swift
//  Finance Tracker app
//
//  Created by Jackson Mugo on 28/08/2025.
//



import Foundation

protocol TransactionRepresentable {
    var id: String { get }
    var date: String { get }
    var description: String { get }
    var category: String { get }
    var amount: Double { get }
    var currency: String { get }
    var type: String { get }
    var account: String { get }
    var balance: Double { get }
    var status: String { get }
}

struct Transaction: TransactionRepresentable, Identifiable, Decodable {
    let id: String
    let date: String
    let description: String
    let category: String
    let amount: Double
    let currency: String
    let type: String
    let account: String
    let balance: Double
    let status: String
}

// Protocol extension for formatting
extension TransactionRepresentable {
    var formattedAmount: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency
        return formatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
    }
}


