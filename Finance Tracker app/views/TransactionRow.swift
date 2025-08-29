//
//  TransactionRow.swift
//  Finance Tracker app
//
//  Created by Jackson Mugo on 28/08/2025.
//


import SwiftUI

struct TransactionRow: View {
    let transaction: TransactionRepresentable
    
    var body: some View {
        HStack(spacing: 12) {
            // Icon placeholder
            Circle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 30, height: 30)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(transaction.description)
                    .font(Font.custom("Product Sans Medium", size: 12))
                    .foregroundColor(.black)
                Text(transaction.date)
                    .font(Font.custom("Product Sans", size: 8))
                    .foregroundColor(Color.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2) {
                Text(transaction.formattedAmount)
                    .font(Font.custom("Product Sans Medium", size: 12))
                    .foregroundColor(transaction.type == "income" ? .green : .red)
                Text(transaction.category)
                    .font(Font.custom("Product Sans", size: 8))
                    .foregroundColor(Color.gray)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.3), lineWidth: 0.5)
        )
    }
}
