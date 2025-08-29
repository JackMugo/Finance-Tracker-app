import PDFKit
import UIKit

func generateTransactionReceipt(transactionId: String, amount: Double, date: Date, recipient: String) -> PDFDocument {
    let pdfDocument = PDFDocument()
    let page = PDFPage()
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
    
    UIGraphicsBeginPDFContextToData(NSMutableData() as Data, pageBounds, nil)
    UIGraphicsBeginPDFPageWithInfo(pageBounds, nil)
    attributedString.draw(in: CGRect(x: 50, y: 100, width: pageWidth - 100, height: pageHeight - 200))
    UIGraphicsEndPDFContext()
    
    pdfDocument.insert(page, at: 0)
    return pdfDocument
}
