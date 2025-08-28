//
//  ExchangeRateListView.swift
//  Finance Tracker app
//
//  Created by Jackson Mugo on 28/08/2025.
//


import SwiftUI

struct ExchangeRateListView: View {
    @StateObject var viewModel: CurrencyViewModel

    var body: some View {
        NavigationView {
            List(viewModel.exchangeRates) { rate in
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(rate.baseCurrency) → \(rate.targetCurrency)")
                        .font(.headline)
                    Text("Rate: \(rate.rate)")
                        .font(.subheadline)
                    Text("Status: \(rate.status)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("Exchange Rates")
        }
    }
}

#Preview {
    // Mock Data for Preview
    let mockRates = [
        ExchangeRate(id: "EXR1001", date: "2025-07-01", baseCurrency: "KES", targetCurrency: "CNY", rate: 0.053, source: "Co-op Bank", status: "Success"),
        ExchangeRate(id: "EXR1002", date: "2025-07-02", baseCurrency: "KES", targetCurrency: "UGX", rate: 27.14, source: "Co-op Bank", status: "Failed")
    ]

    let vm = CurrencyViewModel(service: CurrencyService(apiClient: APIClient()))
    vm.exchangeRates = mockRates
    return ExchangeRateListView(viewModel: vm)
}
