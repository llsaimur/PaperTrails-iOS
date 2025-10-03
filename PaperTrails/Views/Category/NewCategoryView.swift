//
//  NewCategoryView.swift
//  PaperTrails
//
//  Created by Saimur Rashid on 10/2/25.
//

import SwiftUI

struct NewCategoryView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var categoryTitle = ""
    @State private var categoryNote = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // MARK: Title Field
                    VStack {
                        TextField("Category Name", text: $categoryTitle)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                            .font(.title2)
                            .disableAutocorrection(true)
                    }
                    
                    // MARK: Note Field
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Note")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 12)
                            .padding(.top, 12)
                        
                        TextEditor(text: $categoryNote)
                            .padding(12)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                            .frame(height: 80)
                            .font(.body)
                    }
                    
                }
                .padding()
            }
            .background(Color(.systemGray6).ignoresSafeArea())
            .navigationTitle("New Category")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        // TODO: Add category logic
                    }
                }
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
        }
    }
}

#Preview {
    NewCategoryView()
}
