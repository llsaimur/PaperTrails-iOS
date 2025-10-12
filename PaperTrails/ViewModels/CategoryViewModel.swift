//
//  CategoryViewModel.swift
//  PaperTrails
//
//  Created by Saimur Rashid on 10/9/25.
//

import SwiftUI

@MainActor
class CategoryViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    var authViewModel: AuthViewModel
    var token: String? { authViewModel.accessToken }

    init(authViewModel: AuthViewModel) {
        self.authViewModel = authViewModel
    }

    func updateAuthViewModel(_ newAuth: AuthViewModel) {
        self.authViewModel = newAuth
    }

    // MARK: - Fetch Categories
    func fetchCategories() async {
        guard let token = token else { return }
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        let urlString = APIEndpoints.category
        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else { return }

            switch httpResponse.statusCode {
            case 200...299:
                let result = try JSONDecoder().decode(CategoriesListResponse.self, from: data)
                self.categories = result.data.map { Category(from: $0) }

            default:
                let apiError = try? JSONDecoder().decode(APIErrorResponse.self, from: data)
                self.errorMessage = apiError?.error ?? "Failed to fetch categories"
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    // MARK: - Add Category
    func addCategory(name: String, description: String) async -> Bool {
        guard let token = token else { return false }
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        let urlString = APIEndpoints.category
        guard let url = URL(string: urlString) else { return false }

        let body = ["name": name, "description": description]

        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpBody = try JSONSerialization.data(withJSONObject: body)

            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else { return false }

            switch httpResponse.statusCode {
            case 200...299:
                let networkCategory = try JSONDecoder().decode(CategoryResponse.self, from: data)
                let newCategory = Category(from: networkCategory)
                categories.append(newCategory)
                return true

            default:
                let apiError = try? JSONDecoder().decode(APIErrorResponse.self, from: data)
                self.errorMessage = apiError?.error ?? "Failed to create category"
                return false
            }
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }

    // MARK: - Delete Category
    func deleteCategory(id: String) async -> Bool {
        guard let token = token else { return false }
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        let urlString = "\(APIEndpoints.category)/\(id)"
        guard let url = URL(string: urlString) else { return false }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else { return false }

            if httpResponse.statusCode == 200 {
                categories.removeAll { $0.id == id }
                return true
            } else {
                return false
            }
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
    
    // MARK: - Update Category
    func updateCategory(id: String, name: String, description: String) async -> Bool {
        guard let token = token else { return false }
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        let urlString = "\(APIEndpoints.category)/\(id)"
        guard let url = URL(string: urlString) else { return false }

        let body: [String: Any] = ["name": name, "description": description]

        do {
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpBody = try JSONSerialization.data(withJSONObject: body)

            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else { return false }

            switch httpResponse.statusCode {
            case 200...299:
                let updated = try JSONDecoder().decode(CategoryResponse.self, from: data)
                let updatedCategory = Category(from: updated)
                
                if let index = categories.firstIndex(where: { $0.id == id }) {
                    categories[index] = updatedCategory
                }
                return true
                
            default:
                let apiError = try? JSONDecoder().decode(APIErrorResponse.self, from: data)
                self.errorMessage = apiError?.error ?? "Failed to update category"
                return false
            }
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }

}
