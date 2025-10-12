import SwiftUI

struct MainView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var categoryVM: CategoryViewModel
    @State private var searchText: String = ""
    @State private var showNewDocument = false
    @State private var showNewCategory = false
    @State private var categoryToEdit: Category?
    @State private var showEditSheet = false

    init(authViewModel: AuthViewModel) {
        _categoryVM = StateObject(wrappedValue: CategoryViewModel(authViewModel: authViewModel))
    }

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
                .padding(.bottom, 12)
                
                // Category List
                if categoryVM.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(categoryVM.categories.filter {
                            searchText.isEmpty ? true : $0.name.localizedCaseInsensitiveContains(searchText)
                        }) { category in
                            NavigationLink(destination: CategoryDetailView(categoryName: category.name)) {
                                CategoryRowView(category: category)
                                    .padding(.vertical, 8)
                            }
                            .swipeActions(edge: .trailing) {
                                // Delete button
                                Button(role: .destructive) {
                                    Task {
                                        let success = await categoryVM.deleteCategory(id: category.id)
                                        if !success {
                                            print("Failed to delete category")
                                        }
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }

                                // Edit button
                                Button {
                                    categoryToEdit = category
                                    showEditSheet = true
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                .tint(.blue)
                            }
                        }
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                }
                
                Divider()
                
                // Bottom Bar
                HStack {
                    Button(action: { showNewDocument = true }) {
                        VStack {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                            Text("New Document")
                                .font(.caption)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .sheet(isPresented: $showNewDocument) { NewDocumentView() }
                    
                    Button(action: { showNewCategory = true }) {
                        VStack {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                            Text("New Category")
                                .font(.caption)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .sheet(isPresented: $showNewCategory) { NewCategoryView(categoryVM: categoryVM) }
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("PaperTrails")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .task {
                await categoryVM.fetchCategories()
            }
            .sheet(isPresented: $showEditSheet) {
                if let categoryToEdit = categoryToEdit {
                    EditCategoryView(categoryVM: categoryVM, category: categoryToEdit)
                }
            }
        }
    }
}

#Preview {
    MainView(authViewModel: AuthViewModel())
        .environmentObject(AuthViewModel())
}
