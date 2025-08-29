//
//  AddTransactionView 2.swift
//  Finance Tracker app
//
//  Created by Jackson Mugo on 29/08/2025.
//

import SwiftUI

struct AddTransactionView: View {
    
    @ObservedObject var viewModel: TransactionViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedType: TransactionType = .income
    @State private var amount: String = ""
    @State private var date: Date = Date()
    @State private var category: String = "Transport"
    @State private var description: String = ""
    
    enum TransactionType {
        case income, expense
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                
                // Transaction Type Selector
                VStack(alignment: .leading, spacing: 8) {
                    Text("Type")
                        .font(.custom("Product Sans Medium", size: 14))
                        .foregroundColor(.black)
                    
                    HStack(spacing: 120) {
                        ForEach([TransactionType.income, .expense], id: \.self) { type in
                            Button(action: { selectedType = type }) {
                                HStack(spacing: 8) {
                                    Circle()
                                        .strokeBorder(type == selectedType ? Color.green : Color.gray, lineWidth: 1)
                                        .background(Circle().fill(type == selectedType ? Color.green : Color.clear))
                                        .frame(width: 18, height: 18)
                                    Text(type == .income ? "Income" : "Expense")
                                        .font(.custom("Product Sans", size: 12))
                                        .foregroundColor(.black)
                                }
                            }
                        }
                    }
                }
                
                // Amount Field
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 4) {
                        Text("Amount")
                            .font(.custom("Product Sans Medium", size: 14))
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                        Text("(KES)")
                            .font(.custom("Product Sans", size: 12))
                            .foregroundColor(Color.green)
                    }
                    TextField("0.00", text: $amount)
                        .keyboardType(.decimalPad)
                        .padding()
                        .frame(height: 48)
                        .font(.custom("Product Sans Medium", size: 14))
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5), lineWidth: 0.5))
                }
                
                // Date Picker
                VStack(alignment: .leading, spacing: 4) {
                    Text("Date")
                        .font(.custom("Product Sans Medium", size: 14))
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                    
                    HStack {
                        Text(dateFormatted)
                            .font(.custom("Product Sans", size: 14))
                            .foregroundColor(Color(red: 0.20, green: 0.20, blue: 0.20))
                        Spacer()
                        Image("DatePicker")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .padding()
                    .frame(height: 48)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
                    )
                    .overlay(
                        DatePicker("", selection: $date, displayedComponents: .date)
                            .labelsHidden()
                            .opacity(0.015)
                    )
                }
                
                // Category Field
                VStack(alignment: .leading, spacing: 4) {
                    Text("Category")
                        .font(.custom("Product Sans Medium", size: 14))
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                    TextField("Select category", text: $category)
                        .padding()
                        .frame(height: 48)
                        .font(.custom("Product Sans Medium", size: 14))
                        .background(Color(.systemGray5))
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5), lineWidth: 0.5))
                }
                
                // Description Field
                VStack(alignment: .leading, spacing: 4) {
                    Text("Description")
                        .font(.custom("Product Sans Medium", size: 14))
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                    TextField("Add description", text: $description)
                        .padding()
                        .frame(height: 48)
                        .font(.custom("Product Sans Medium", size: 14))
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5), lineWidth: 0.5))
                }
                
                // Add Transaction Button
                Button(action: addTransaction) {
                    Text("Add Transaction")
                        .font(.custom("Product Sans Medium", size: 14))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 0.40, green: 0.58, blue: 0.12))
                        .cornerRadius(8)
                }
                
                Spacer(minLength: 24)
            }
            .padding(16)
        }
        
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            // Custom Back Button
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image("ArrowBack")
                        .foregroundColor(.black)
                        .imageScale(.medium)
                }
            }
            
            // Left-Aligned Title
            ToolbarItem(placement: .principal) {
                HStack {
                    Text("Add Transaction")
                        .font(.custom("Product Sans Medium", size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Spacer() // Pushes title to the left
                }
            }
        }
        
        .background(Color(red: 0.95, green: 0.95, blue: 0.95).edgesIgnoringSafeArea(.all))
    }
    
    var dateFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }
    
    private func addTransaction() {
        guard let amt = Double(amount) else { return }
        let newTransaction = Transaction(
            id: UUID().uuidString,
            date: dateFormatted,
            description: description,
            category: category,
            amount: amt,
            currency: "KES",
            type: selectedType == .income ? "income" : "expense",
            account: "Default",
            balance: 0,
            status: "completed"
        )
        
        viewModel.addTransaction(newTransaction, isIncome: selectedType == .income)
        dismiss()
    }
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddTransactionView(viewModel: TransactionViewModel(service: TransactionService()))
        }
    }
}

