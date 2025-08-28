//
//  TransactionListView.swift
//  Finance Tracker app
//
//  Created by Jackson Mugo on 28/08/2025.
//

import SwiftUI

struct TransactionListView: View {
    @StateObject var viewModel: TransactionViewModel

    var body: some View {
        NavigationView {
            List(viewModel.transactions) { txn in
                VStack(alignment: .leading, spacing: 6) {
                    Text(txn.description)
                        .font(.headline)
                    Text("\(txn.category) • \(txn.date)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    HStack {
                        Text(txn.formattedAmount)
                            .foregroundColor(txn.type == "debit" ? .red : .green)
                        Spacer()
                        Text(txn.status)
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("Transactions")
        }
    }
}

#Preview {
    // Mock Data for Preview
    let mockTransactions = [
        Transaction(id: "TXN1001", date: "2025-06-29", description: "Bolt Ride", category: "Transport", amount: -3303.96, currency: "KES", type: "debit", account: "M-Pesa", balance: 73346.44, status: "Success"),
        Transaction(id: "TXN1002", date: "2025-08-05", description: "Hospital Bill", category: "Healthcare", amount: -12096.39, currency: "KES", type: "debit", account: "Co-op", balance: 143890.44, status: "Failed")
    ]

    let vm = TransactionViewModel(service: TransactionService(apiClient: APIClient()))
    vm.transactions = mockTransactions
    return TransactionListView(viewModel: vm)
}

