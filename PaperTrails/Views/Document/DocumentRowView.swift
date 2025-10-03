//
//  DocumentRowView.swift
//  PaperTrails
//
//  Created by Saimur Rashid on 10/3/25.
//

import SwiftUI

struct DocumentRowView: View {
    let document: Document
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(document.title)
                    .font(.headline)
                Text(document.date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            if document.attachments > 0 {
                HStack(spacing: 4) {
                    Image(systemName: "paperclip")
                        .foregroundColor(.gray)
                    Text("\(document.attachments)")
                        .foregroundColor(.gray)
                        .font(.footnote)
                }
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    DocumentRowView(
        document: Document(
            title: "Rogers Phone Plan",
            date: "Sep 23, 2025",
            attachments: 2,
            description: "Monthly bill for Rogers phone plan with details of charges.",
            image: nil as UIImage?,                  // <-- added
            pdfURL: nil as URL?
        )
    )
}

