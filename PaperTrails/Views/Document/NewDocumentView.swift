//
//  NewDocumentView.swift
//  PaperTrails
//
//  Created by Saimur Rashid on 10/2/25.
//

import SwiftUI

struct NewDocumentView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var documentTitle = ""
    @State private var notes = ""
    @State private var selectedCategory = "Tickets"
    @State private var showCategoryPicker = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // MARK: Title Field
                    VStack {
                        TextField("Enter document title", text: $documentTitle)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                            .font(.title2)
                            .disableAutocorrection(true)
                    }
                    
                    // MARK: Note Field
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Description")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 12)
                            .padding(.top, 12)
                        
                        TextEditor(text: $notes)
                            .padding(12)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                            .frame(height: 80)
                            .font(.body)
                    }
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                    
                    // MARK: Attachments Row
                    HStack {
                        Button(action: {
                            // TODO: Add attachment/picture
                        }) {
                            HStack {
                                Image(systemName: "camera.fill")
                                Text("Add Attachment")
                            }
                            .foregroundColor(.blue)
                        }
                        Spacer()
                        Text("2 Attachments") // dummy value for now
                            .foregroundColor(.gray)
                            .font(.footnote)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                    
                    // MARK: Category Selector Row
                    Button(action: {
                        showCategoryPicker.toggle()
                    }) {
                        HStack {
                            Text("Category")
                                .foregroundColor(.black)
                            Spacer()
                            HStack(spacing: 4) {
                                Text(selectedCategory)
                                    .foregroundColor(.blue)
                                Image(systemName: showCategoryPicker ? "chevron.up" : "chevron.right")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                    }
                    
                    if showCategoryPicker {
                        CategoryPickerView(selectedCategory: $selectedCategory)
                            .padding(.horizontal, 4)
                    }
                }
                .padding()
            }
            .background(Color(.systemGray6).ignoresSafeArea())
            .navigationTitle("New Document")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        // TODO: Add document logic
                    }
                }
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
        }
    }
}


// MARK: - UIApplication Keyboard Dismiss Extension
extension UIApplication {
    func endEditing() {
        connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?
            .endEditing(true)
    }
}

#Preview {
    NewDocumentView()
}
