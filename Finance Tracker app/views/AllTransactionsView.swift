//
//  AllTransactionsView.swift
//  Finance Tracker app
//
//  Created by Jackson Mugo on 29/08/2025.
//


import SwiftUI

struct AllTransactionsView: View {
    
    @ObservedObject var viewModel: TransactionViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            // Custom Navigation Bar
            HStack {
                Button(action: { dismiss() }) {
                    Image("ArrowBack")
                        .foregroundColor(.black)
                }
                
                Text("All Transactions")
                    .font(.custom("Product Sans Medium", size: 20))
                    .foregroundColor(.black)
                
                Spacer()
            }
            .padding()
            
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.transactions) { transaction in
                        TransactionCard(transaction: transaction)
                    }
                }
                .padding()
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarHidden(true)
    }
}

// MARK: - Transaction Card
struct TransactionCard: View {
    let transaction: Transaction
    
    var body: some View {
        HStack(spacing: 12) {
            // Optional icon based on transaction type
            Circle()
                .fill(transaction.amount >= 0 ? Color.green.opacity(0.5) : Color.red.opacity(0.5))
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: transaction.amount >= 0 ? "arrow.down.circle" : "arrow.up.circle")
                        .foregroundColor(transaction.amount >= 0 ? .green : .red)
                        .font(.system(size: 20))
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.description)
                    .font(.custom("Product Sans Medium", size: 14))
                    .foregroundColor(.black)
                Text(transaction.date)
                    .font(.custom("Product Sans", size: 12))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text(String(format: "%@ %.2f", transaction.currency, transaction.amount))
                .font(.custom("Product Sans Medium", size: 14))
                .foregroundColor(transaction.amount >= 0 ? .green : .red)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}

// MARK: - Preview
struct AllTransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = TransactionViewModel(service: TransactionService())
        
        AllTransactionsView(viewModel: viewModel)
            .previewDevice("iPhone 15 Pro")
            .preferredColorScheme(.light)
    }
}
