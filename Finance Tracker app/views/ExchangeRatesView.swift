//
//  ExchangeRatesView.swift
//  Finance Tracker app
//
//  Created by Jackson Mugo on 29/08/2025.
//

import SwiftUI

struct ExchangeRatesView: View {
    
    @StateObject var viewModel: CurrencyViewModel
    @Environment(\.dismiss) private var dismiss
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(viewModel.exchangeRates) { rate in
                    ExchangeRateCard(
                        baseCurrency: rate.targetCurrency,
                        targetCurrency: rate.targetCurrency,
                        buyRate: rate.rate,       // assuming your API has only 1 rate
                        sellRate: rate.rate,      // duplicate for now
                        countryName: CurrencyUtils.getCountryName(for: rate.targetCurrency),
                        currencyName: CurrencyUtils.getCurrencyName(for: rate.targetCurrency)
                    )
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image("ArrowBack")
                        .foregroundColor(.black)
                        .imageScale(.medium)
                }
            }
            ToolbarItem(placement: .principal) {
                HStack {
                    Text("Exchange Rates")
                        .font(.custom("Product Sans Medium", size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Spacer()
                }
            }
        }
        .task {
            await viewModel.loadExchangeRates()
        }
    }
   

}

struct ExchangeRateCard: View {
    let baseCurrency: String
    let targetCurrency: String
    let buyRate: Double?
    let sellRate: Double?
    let countryName: String
    let currencyName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Top row: currency code + name on left, flag on right
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(baseCurrency)
                        .font(.custom("Product Sans", size: 16).weight(.bold))
                        .foregroundColor(.black)
                    Text("\(countryName) \(currencyName)")
                        .font(.custom("Product Sans", size: 12))
                        .foregroundColor(.gray)
                }
                Spacer()
                Image(baseCurrency) // Make sure you have images named USD, KES, EUR, etc.
                    .resizable()
                    .frame(width: 36, height: 24)
                    .cornerRadius(4)
                    .shadow(radius: 2)
            }
            
            Divider()
            
            // Bottom rows: Buy and Sell
            VStack(spacing: 4) {
                HStack {
                    Text("Buy")
                        .font(.custom("Product Sans", size: 12).weight(.bold))
                        .foregroundColor(Color(red: 0, green: 0.47, blue: 0.29))
                    Spacer()
                    Text(buyRate != nil ? String(format: "%.2f", buyRate!) : "0.00")
                        .font(.custom("Product Sans", size: 14).weight(.bold))
                        .foregroundColor(.black)
                }
                
                HStack {
                    Text("Sell")
                        .font(.custom("Product Sans", size: 12).weight(.bold))
                        .foregroundColor(Color(red: 1, green: 0.09, blue: 0.09))
                    Spacer()
                    Text(sellRate != nil ? String(format: "%.2f", sellRate!) : "0.00")
                        .font(.custom("Product Sans", size: 14).weight(.bold))
                        .foregroundColor(.black)
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.15), radius: 6, x: 0, y: 4)
        .frame(height: 140)
    }
}

struct ExchangeRatesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            let context = PersistenceController.preview.container.viewContext
            let service = CurrencyService(apiClient: APIClient())
            let viewModel = CurrencyViewModel(service: service, context: context)
            
            ExchangeRatesView(viewModel: viewModel)
        }
    }
}
