//
//  Finance_Tracker_appApp.swift
//  Finance Tracker app
//
//  Created by Jackson Mugo on 28/08/2025.
//

import SwiftUI

@main
struct FinanceTrackerApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            TabView {
                TransactionListView(
                    viewModel: TransactionViewModel(
                        service: TransactionService(apiClient: APIClient())
                    )
                )
                .tabItem {
                    Label("Transactions", systemImage: "list.bullet")
                }

                ExchangeRateListView(
                    viewModel: CurrencyViewModel(
                        service: CurrencyService(apiClient: APIClient())
                    )
                )
                .tabItem {
                    Label("Rates", systemImage: "dollarsign.circle")
                }
            }
        }
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}

