//
//  Finance_Tracker_appApp.swift
//  Finance Tracker app
//
//  Created by Jackson Mugo on 28/08/2025.
//

import SwiftUI
import CoreData

@main
struct FinanceTrackerApp: App {
    let persistenceController = PersistenceController.shared
    
    // Create shared instances here
    let context: NSManagedObjectContext
    let service: CurrencyService
    let exchangeRatesVM: CurrencyViewModel
    
    init() {
        context = persistenceController.container.viewContext
        service = CurrencyService(apiClient: APIClient())
        exchangeRatesVM = CurrencyViewModel(service: service, context: context)
        
        // Tab bar appearance
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor.white
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
    }
    
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", image: "Home")
                    }
                
                ExchangeRatesTab(viewModel: exchangeRatesVM)
                    .tabItem {
                        Label("Exchange Rate", image: "ExchangeRates")
                    }
                
                MoreView()
                    .tabItem {
                        Label("More", image: "More")
                    }
            }
            .accentColor(Color(red: 0.50, green: 0.73, blue: 0.15))
            .environment(\.managedObjectContext, context)
        }
    }
}


