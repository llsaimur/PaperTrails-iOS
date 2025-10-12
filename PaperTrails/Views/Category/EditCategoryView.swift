//
//  EditCategoryView.swift
//  PaperTrails
//
//  Created by Saimur Rashid on 10/11/25.
//


import SwiftUI

struct EditCategoryView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var categoryVM: CategoryViewModel
    
    @State var category: Category
    @State private var isSaving = false
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Title Field
                    TextField("Category Name", text: $category.name)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                        .font(.title2)
                        .disableAutocorrection(true)
                    
                    // Note Field
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Note")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 12)
                            .padding(.top, 12)
                        
                        TextEditor(text: Binding(
                            get: { category.description ?? "" },
                            set: { category.description = $0 }
                        ))
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
            .navigationTitle("Edit Category")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        Task {
                            await updateCategory()
                        }
                    }
                    .disabled(category.name.isEmpty || isSaving)
                }
            }
            .alert("Error", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    private func updateCategory() async {
        isSaving = true
        let success = await categoryVM.updateCategory(id: category.id, name: category.name, description: category.description ?? "")
        isSaving = false
        
        if success {
            dismiss()
        } else {
            alertMessage = categoryVM.errorMessage ?? "Failed to update category"
            showAlert = true
        }
    }
}
