//
//  ExchangeRatesTab.swift
//  Finance Tracker app
//
//  Created by Jackson Mugo on 29/08/2025.
//

import SwiftUI

struct ExchangeRatesTab: View {
    @StateObject private var viewModel: CurrencyViewModel

    init(viewModel: CurrencyViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            ExchangeRatesView(viewModel: viewModel)
        }
        .tabItem {
            Label("Exchange Rate", image: "ExchangeRates")
        }
    }
}

