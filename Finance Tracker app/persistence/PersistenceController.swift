//
//  PersistenceController.swift
//  Finance Tracker app
//
//  Created by Jackson Mugo on 28/08/2025.
//


import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    // Preview instance for SwiftUI previews
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        return controller
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Finance_Tracker_app") // name must match your .xcdatamodeld
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { desc, error in
            if let error = error {
                fatalError("❌ Failed to load Core Data: \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
