//
//  Finance_Tracker_appApp.swift
//  Finance Tracker app
//
//  Created by Jackson Mugo on 28/08/2025.
//

import SwiftUI

@main
struct Finance_Tracker_appApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
