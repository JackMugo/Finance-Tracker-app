//
//  MoreView.swift
//  Finance Tracker app
//
//  Created by Jackson Mugo on 29/08/2025.
//


import SwiftUI

struct MoreView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let menuItems: [(icon: String, title: String)] = [
        ("Profile", "Profile"),
        ("Settings", "Settings"),
        ("Notifications", "Notifications"),
        ("Help", "Help & Support"),
        ("Logout", "Logout")
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                
                ForEach(menuItems, id: \.title) { item in
                    HStack {
                        // Placeholder icon; replace with your asset names
                        Image(systemName: "circle.fill")
                            .foregroundColor(.green)
                            .frame(width: 32, height: 32)
                        
                        Text(item.title)
                            .font(.custom("Product Sans", size: 16).weight(.medium))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                }
            }
            .padding()
        }
        .navigationBarTitle("More", displayMode: .inline)
    }
}

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MoreView()
        }
    }
}
