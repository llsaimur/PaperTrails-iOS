import SwiftUI
import PDFKit

struct DocumentDetailView: View {
    let documentTitle: String
    let documentDescription: String
    let documentDate: String
    let documentImage: UIImage?
    let documentPDF: URL?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                // Document Preview
                if let pdfURL = documentPDF {
                    PDFKitView(url: pdfURL)
                        .frame(height: 400)
                        .cornerRadius(12)
                        .padding(.horizontal)
                } else if let image = documentImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                        .padding(.horizontal)
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 400)
                        .cornerRadius(12)
                        .overlay(
                            Text("No Preview Available")
                                .foregroundColor(.secondary)
                        )
                        .padding(.horizontal)
                }
                
                // Document Date
                Text(documentDate)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                // Document Info
                VStack(alignment: .leading, spacing: 8) {
                    Text(documentTitle)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Divider()
                    
                    Text(documentDescription)
                        .font(.body)
                        .foregroundColor(.primary)
                }
                .padding(.horizontal)
                
                Spacer(minLength: 40)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    // more options
                }) {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.black)
                }
            }
        }
    }
    
    // PDFKit wrapper for SwiftUI
    struct PDFKitView: UIViewRepresentable {
        let url: URL
        
        func makeUIView(context: Context) -> PDFView {
            let pdfView = PDFView()
            pdfView.document = PDFDocument(url: url)
            pdfView.autoScales = true
            pdfView.displayMode = .singlePageContinuous
            pdfView.displayDirection = .vertical
            return pdfView
        }
        
        func updateUIView(_ uiView: PDFView, context: Context) {}
    }
}

#Preview {
    NavigationStack {
        // Example using first document from dummy data
        DocumentDetailView(
            documentTitle: "Rogers Phone Plan",
            documentDescription: "Monthly bill for Rogers phone plan with details of charges.",
            documentDate: "Sep 23, 2025",
            documentImage: UIImage(named: "sampleDoc"),
            documentPDF: nil
        )
    }
}
