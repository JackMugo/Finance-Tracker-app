//
//  AddTransactionView.swift
//  Finance Tracker app
//
//  Created by Jackson Mugo on 28/08/2025.
//


import SwiftUI

struct AddTransactionView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var isIncome: Bool = false
    @State private var amount: String = ""
    @State private var date: Date = Date()
    @State private var category: String = "Transport"
    @State private var descriptionText: String = ""
    
    let categories = ["Transport", "Shopping", "Healthcare", "Education", "Other"]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // MARK: Transaction Type
                    HStack {
                        RadioButton(label: "Income", isSelected: isIncome) {
                            isIncome = true
                        }
                        Spacer()
                        RadioButton(label: "Expense", isSelected: !isIncome) {
                            isIncome = false
                        }
                    }
                    
                    // MARK: Amount
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Amount (KES)")
                            .font(.headline)
                        TextField("0.00", text: $amount)
                            .keyboardType(.decimalPad)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))
                    }
                    
                    // MARK: Date
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Date")
                            .font(.headline)
                        DatePicker("", selection: $date, displayedComponents: [.date])
                            .datePickerStyle(.compact)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))
                    }
                    
                    // MARK: Category
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Category")
                            .font(.headline)
                        Picker("Select Category", selection: $category) {
                            ForEach(categories, id: \.self) { cat in
                                Text(cat).tag(cat)
                            }
                        }
                        .pickerStyle(.menu)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))
                    }
                    
                    // MARK: Description
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Description")
                            .font(.headline)
                        TextField("Enter description...", text: $descriptionText)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))
                    }
                    
                    // MARK: Add Button
                    Button(action:saveTransaction) {
                        Text("Add Transaction")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.top, 30)
                    
                }
                .padding()
            }
            .navigationTitle("Add Transaction")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium   // e.g. "Aug 28, 2025"
        formatter.timeStyle = .short    // e.g. "7:35 PM"
        return formatter.string(from: date)
    }
    
    private func saveTransaction() {
        let newTx = TransactionEntity(context: viewContext)
        newTx.id = UUID()
        newTx.amount = Double(amount) ?? 0
        newTx.date = dateToString(date: date)
        newTx.category = category
        newTx.descriptionText = descriptionText
        newTx.isIncome = isIncome
        
        do {
            try viewContext.save()
            print("✅ Transaction saved!")
            dismiss()
        } catch {
            print("❌ Failed to save transaction: \(error.localizedDescription)")
        }
    }
    
}

// MARK: - Custom Radio Button
struct RadioButton: View {
    var label: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Circle()
                    .stroke(isSelected ? Color.green : Color.gray, lineWidth: 2)
                    .frame(width: 20, height: 20)
                    .overlay(
                        Circle()
                            .fill(isSelected ? Color.green : Color.clear)
                            .frame(width: 12, height: 12)
                    )
                Text(label)
                    .foregroundColor(.primary)
            }
        }
    }
    
    
}

#Preview {
    AddTransactionView()
}



