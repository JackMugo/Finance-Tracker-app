//
//  TransactionViewModel.swift
//  Finance Tracker app
//
//  Created by Jackson Mugo on 28/08/2025.
//



import CoreData

@MainActor
class TransactionViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    private let service: TransactionServiceProtocol
    private let context: NSManagedObjectContext

    init(service: TransactionServiceProtocol, context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.service = service
        self.context = context
    }

    func loadTransactions() async {
        do {
            let result = try await service.fetchTransactions()
            self.transactions = result
            saveToCoreData(result)
        } catch {
            print("❌ Error fetching transactions: \(error)")
            loadFromCoreData()
        }
    }

    private func saveToCoreData(_ txns: [Transaction]) {
        for txn in txns {
            // avoid duplicates
            let fetch: NSFetchRequest<TransactionEntity> = TransactionEntity.fetchRequest()
            fetch.predicate = NSPredicate(format: "transId == %@", txn.id)
            
            if let existing = try? context.fetch(fetch), existing.isEmpty == false {
                continue // already saved
            }
            
            let cdTxn = TransactionEntity(context: context)
            cdTxn.transId = txn.id
            cdTxn.date = txn.date
            cdTxn.descriptionText = txn.description
            cdTxn.category = txn.category
            cdTxn.amount = txn.amount
            cdTxn.currency = txn.currency
            cdTxn.type = txn.type
            cdTxn.account = txn.account
            cdTxn.balance = txn.balance
            cdTxn.status = txn.status
            cdTxn.isIncome = (txn.type.lowercased() == "income")
        }
        try? context.save()
    }

    private func loadFromCoreData() {
        let request: NSFetchRequest<TransactionEntity> = TransactionEntity.fetchRequest()
        if let saved = try? context.fetch(request) {
            self.transactions = saved.map {
                Transaction(
                    id: $0.transId ?? UUID().uuidString,
                    date: $0.date ?? "",
                    description: $0.descriptionText ?? "",
                    category: $0.category ?? "",
                    amount: $0.amount,
                    currency: $0.currency ?? "KES",
                    type: $0.type ?? "",
                    account: $0.account ?? "",
                    balance: $0.balance,
                    status: $0.status ?? ""
                )
            }
        }
    }
    
    // to save a single transaction
        func addTransaction(_ transaction: Transaction, isIncome: Bool) {
            transactions.insert(transaction, at: 0)
            
            let cdTxn = TransactionEntity(context: context)
            cdTxn.transId = transaction.id
            cdTxn.date = transaction.date
            cdTxn.descriptionText = transaction.description
            cdTxn.category = transaction.category
            cdTxn.amount = transaction.amount
            cdTxn.currency = transaction.currency
            cdTxn.type = transaction.type
            cdTxn.account = transaction.account
            cdTxn.balance = transaction.balance
            cdTxn.status = transaction.status
            cdTxn.isIncome = isIncome
            
            try? context.save()
        }
}

