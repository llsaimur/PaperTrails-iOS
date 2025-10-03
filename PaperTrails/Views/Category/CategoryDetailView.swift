import SwiftUI

struct CategoryDetailView: View {
    let categoryName: String
    @State private var searchText = ""
    @State private var expandLast7Days = true

    // Dummy data
    let documentsLast7Days = [
        Document(
            title: "Rogers Phone Plan",
            date: "Sep 23, 2025",
            attachments: 2,
            description: "Monthly bill for Rogers phone plan with details of charges.",
            image: nil as UIImage?,                  // <-- added
            pdfURL: nil as URL?
        ),
        Document(
            title: "Electric Bill",
            date: "Sep 21, 2025",
            attachments: 1,
            description: "Electric bill for September 2025.",
            image: nil as UIImage?,                  // <-- added
            pdfURL: nil as URL?
        )
    ]


    let documentsLast30Days = [
        Document(
            title: "Internet Bill",
            date: "Sep 10, 2025",
            attachments: 3,
            description: "Monthly internet service charges.",
            image: nil as UIImage?,                  // <-- added
            pdfURL: nil as URL?
        ),
        Document(
            title: "Insurance Renewal",
            date: "Sep 1, 2025",
            attachments: 0,
            description: "Insurance renewal for your vehicle.",
            image: nil as UIImage?,                  // <-- added
            pdfURL: nil as URL?
        )
    ]

    var body: some View {
        VStack(spacing: 0) {
            // Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search", text: $searchText)
                    .disableAutocorrection(true)
                Button(action: {
                    // mic action
                }) {
                    Image(systemName: "mic.fill")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .padding(.horizontal)
            .padding(.top, 8)
            .padding(.bottom, 24)

            List {
                // Previous 7 Days
                Section(header: HStack {
                    Text("Previous 7 Days")
                        .font(.headline)
                    Spacer()
                    Button(action: { expandLast7Days.toggle() }) {
                        Image(systemName: expandLast7Days ? "chevron.down" : "chevron.right")
                            .foregroundColor(.gray)
                    }
                }) {
                    if expandLast7Days {
                        ForEach(documentsLast7Days) { doc in
                            NavigationLink(destination: DocumentDetailView(
                                documentTitle: doc.title,
                                documentDescription: doc.description,
                                documentDate: doc.date,
                                documentImage: doc.image,
                                documentPDF: doc.pdfURL
                            )) {
                                DocumentRowView(document: doc)
                            }
                        }
                    }
                }

                // Previous 30 Days
                Section(header: Text("Previous 30 Days").font(.headline)) {
                    ForEach(documentsLast30Days) { doc in
                        NavigationLink(destination: DocumentDetailView(
                            documentTitle: doc.title,
                            documentDescription: doc.description,
                            documentDate: doc.date,
                            documentImage: doc.image,
                            documentPDF: doc.pdfURL
                        )) {
                            DocumentRowView(document: doc)
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(categoryName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.black)
                    }
                }
            }

            // total documents
            Text("\(documentsLast7Days.count + documentsLast30Days.count) Documents")
                .foregroundColor(.gray)
                .font(.footnote)
                .padding(.vertical, 8)
        }
    }
}


#Preview {
    NavigationStack {
        CategoryDetailView(categoryName: "Bills")
    }
}
