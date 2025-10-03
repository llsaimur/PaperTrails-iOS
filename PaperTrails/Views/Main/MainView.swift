//
//  MainView.swift
//  PaperTrails
//
//  Created by Saimur Rashid on 9/30/25.
//

import SwiftUI

struct MainView: View {
    // Dummy data for now (later: fetch from user-added categories/documents)
        @State private var categories: [Category] = [
            Category(name: "Bills", documentCount: 6),
            Category(name: "Insurance", documentCount: 3),
            Category(name: "Tickets", documentCount: 0)
        ]
        
        @State private var searchText: String = ""
        @State private var showNewDocument = false
        @State private var showNewCategory = false
        
        var body: some View {
            NavigationStack {
                VStack(spacing: 0) {
                    
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search", text: $searchText)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                    .padding(.horizontal)
                    .padding(.top, 10)
                    .padding(.bottom,24)

                    
                    Spacer()
                    
                    // Category List
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(categories) { category in
                                NavigationLink(destination: CategoryDetailView(categoryName: category.name)) {CategoryRowView(category: category)
                                        .padding()
                                        .frame(maxWidth: .infinity, alignment:
                                                .leading)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }

                    Divider()
                    
                    // Bottom Bar
                    HStack {
                        Button(action: {
                            showNewDocument = true
                        }) {
                            VStack {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title2)
                                Text("New Document")
                                    .font(.caption)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        
                        .sheet(isPresented: $showNewDocument) {
                                        NewDocumentView()
                                    }
                        
                        Button(action: {
                            showNewCategory = true
                        }) {
                            VStack {
                                Image(systemName: "folder.badge.plus")
                                    .font(.title2)
                                Text("Category")
                                    .font(.caption)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        
                        .sheet(isPresented: $showNewCategory) {
                                        NewCategoryView()
                                    }
                    }
                    .padding(.vertical, 8)
                }
                .navigationTitle("PaperTrails")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
            }
        }
    }

#Preview {
    MainView()
}
