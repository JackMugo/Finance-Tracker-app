//
//  MoreView.swift
//  Finance Tracker app
//
//  Created by Jackson Mugo on 29/08/2025.
//

//
//import SwiftUI
//
//struct MoreView: View {
//    
//    @Environment(\.dismiss) private var dismiss
//    @State private var pdfDocument: PDFDocument?
//    @State private var showPDF: Bool = false
//    
//    let menuItems: [(icon: String, title: String)] = [
//        ("Profile", "Profile"),
//        ("Settings", "Settings"),
//        ("Notifications", "Notifications"),
//        ("Help", "Help & Support"),
//        ("Logout", "Logout")
//    ]
//    
//    let columns = [
//        GridItem(.flexible()),
//        GridItem(.flexible())
//    ]
//    
//    var body: some View {
//        ScrollView {
//            VStack(spacing: 16) {
//                
//                ForEach(menuItems, id: \.title) { item in
//                    HStack {
//                        // Placeholder icon; replace with your asset names
//                        Image(systemName: "circle.fill")
//                            .foregroundColor(.green)
//                            .frame(width: 32, height: 32)
//                        
//                        Text(item.title)
//                            .font(.custom("Product Sans", size: 16).weight(.medium))
//                            .foregroundColor(.black)
//                        
//                        Spacer()
//                        
//                        Image(systemName: "chevron.right")
//                            .foregroundColor(.gray)
//                    }
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(12)
//                    .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
//                }
//            }
//            .padding()
//        }
//        .navigationBarTitle("More", displayMode: .inline)
//    }
//}
//
//struct MoreView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            MoreView()
//        }
//    }
//}




//
//  MoreView.swift
//  Finance Tracker app
//
//  Created by Jackson Mugo on 29/08/2025.
//

import SwiftUI
import PDFKit
import UIKit
import CoreData

struct MoreView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var pdfDocument: PDFDocument?
    @State private var showPDF: Bool = false
    
    let menuItems: [(icon: String, title: String)] = [
        ("person.circle", "Profile"),
        ("gearshape", "Settings"),
        ("bell", "Notifications"),
        ("questionmark.circle", "Help & Support"),
        ("doc.text", "Generate Receipt"), // New item
        ("arrow.right.square", "Logout")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(menuItems, id: \.title) { item in
                    HStack {
                        Image(systemName: item.icon)
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
                    .onTapGesture {
                        handleTap(for: item.title)
                    }
                }
            }
            .padding()
        }
        .navigationBarTitle("More", displayMode: .inline)
        .sheet(isPresented: $showPDF) {
            if let pdf = pdfDocument {
                PDFKitView(pdfDocument: pdf)
                    .edgesIgnoringSafeArea(.all)
            } else {
                Text("Failed to generate PDF")
            }
        }
    }
    
    private func handleTap(for title: String) {
        if title == "Generate Receipt" {
            pdfDocument = generateTransactionReceipt(
                transactionId: "TXN123456",
                amount: 152500,
                date: Date(),
                recipient: "John Doe"
            )
            showPDF = true
        }
    }
}

// MARK: - PDFKit SwiftUI Wrapper
struct PDFKitView: UIViewRepresentable {
    let pdfDocument: PDFDocument
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = pdfDocument
        pdfView.autoScales = true
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {}
}

// MARK: - PDF Generator
func generateTransactionReceipt(transactionId: String, amount: Double, date: Date, recipient: String) -> PDFDocument {
    
    let pdfData = NSMutableData()
    
    let pageWidth: CGFloat = 595
    let pageHeight: CGFloat = 842
    let pageBounds = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
    
    let receiptText = """
    Transaction Receipt
    
    Transaction ID: \(transactionId)
    Date: \(date.formatted(.dateTime.month().day().year().hour().minute()))
    Recipient: \(recipient)
    
    Amount Paid: KES \(String(format: "%.2f", amount))
    
    Thank you for using Finance Tracker!
    """
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .left
    let attributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 16, weight: .medium),
        .paragraphStyle: paragraphStyle
    ]
    
    let attributedString = NSAttributedString(string: receiptText, attributes: attributes)
    
    // Begin PDF context with proper NSMutableData
    UIGraphicsBeginPDFContextToData(pdfData, pageBounds, nil)
    UIGraphicsBeginPDFPageWithInfo(pageBounds, nil)
    
    // Draw the receipt text
    attributedString.draw(in: CGRect(x: 50, y: 100, width: pageWidth - 100, height: pageHeight - 200))
    
    UIGraphicsEndPDFContext()
    
    // Create PDFDocument from the generated data
    guard let document = PDFDocument(data: pdfData as Data) else {
        return PDFDocument()
    }
    
    return document
}


// MARK: - Preview
struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MoreView()
        }
    }
}
