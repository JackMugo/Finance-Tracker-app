//
//  HomeView.swift
//  Finance Tracker app
//
//  Created by Jackson Mugo on 28/08/2025.
//


import SwiftUI

//
//  HomeView.swift
//  Finance Tracker app
//
//  Created by Jackson Mugo on 28/08/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = TransactionViewModel(service: TransactionService())
    
    var body: some View {
        NavigationStack {
            ScrollView { // ScrollView to avoid clipping on small screens
                VStack(spacing: 20) {
                    
                    // Greeting
                    HStack {
                        Circle()
                            .fill(Color(red: 0.5, green: 0.23, blue: 0.27).opacity(0.5))
                            .frame(width: 40, height: 40)
                        Text("Good Morning Tony")
                            .font(.custom("Product Sans Medium", size: 16))
                    }
                    .padding(.top)
                    
                    //  Balance Card
                    VStack(spacing: 16) {
                        Text("Current Balance")
                            .font(.custom("Product Sans", size: 10))
                            .foregroundColor(Color.gray.opacity(0.8))
                        
                        HStack(spacing: 4) {
                            Text("152,500.00")
                                .font(.custom("Product Sans Medium", size: 24))
                                .foregroundColor(.white)
                            Text("KES")
                                .font(.custom("Product Sans", size: 10))
                                .foregroundColor(.white)
                        }
                        
                        HStack(spacing: 32) {
                            VStack(spacing: 2) {
                                Text("Money In")
                                    .font(.custom("Product Sans", size: 10))
                                    .foregroundColor(Color(red: 0.86, green: 0.98, blue: 0.76))
                                Text("KES 120,000.00")
                                    .font(.custom("Product Sans", size: 10).weight(.bold))
                                    .foregroundColor(Color(red: 0.85, green: 0.98, blue: 0.76))
                            }
                            
                            Rectangle()
                                .frame(width: 1, height: 24)
                                .foregroundColor(.white.opacity(0.5))
                                .padding(.horizontal, 16)
                            
                            VStack(spacing: 2) {
                                Text("Money Out")
                                    .font(.custom("Product Sans", size: 10))
                                    .foregroundColor(Color(red: 0.86, green: 0.98, blue: 0.76))
                                Text("KES 12,000.00")
                                    .font(.custom("Product Sans", size: 10).weight(.bold))
                                    .foregroundColor(Color(red: 0.85, green: 0.98, blue: 0.76))
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 0.04, green: 0.10, blue: 0.07))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    
                    // Transactions Section
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Recent Five Transactions")
                                .font(Font.custom("Product Sans Medium", size: 14))
                                .foregroundColor(.black)
                            Spacer()
                            
                            NavigationLink(destination: AllTransactionsView(viewModel: viewModel)) {
                                   Text("View All")
                                       .font(Font.custom("Product Sans", size: 12))
                                       .foregroundColor(Color(red: 0.50, green: 0.73, blue: 0.15))
                               }
                            
                        }
                        
                        VStack(spacing: 10) {
                            ForEach(viewModel.transactions.prefix(5)) { transaction in
                                TransactionRow(transaction: transaction)
                            }
                        }
                        
                       
                        NavigationLink(destination: AddTransactionView(viewModel: viewModel)) {
                            Text("Add Transaction")
                                .font(Font.custom("Product Sans", size: 12))
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(red: 0.40, green: 0.58, blue: 0.12))
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .task {
                await viewModel.loadTransactions()
            }
            .background(Color(.systemGroupedBackground))
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

// MARK: - Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewDevice("iPhone 15 Pro")
            .preferredColorScheme(.light)
    }
}
