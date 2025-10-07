import SwiftUI
import Combine

@MainActor
class AuthViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var registrationSuccess = false
    @Published var isAuthenticated = false
    @Published var accessToken: String? = nil
    
    func register(firstName: String, lastName: String, email: String, password: String) async {
        isLoading = true
        errorMessage = nil

        defer { isLoading = false } // Always reset loading even if error occurs
        
        let url = URL(string: APIEndpoints.register)!
        let requestBody = RegisterRequest(
            name: "\(firstName) \(lastName)",
            email: email,
            password: password
        )

        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(requestBody)

            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }

            switch httpResponse.statusCode {
            case 200...299:
                registrationSuccess = true

            default:
                let apiError = try? JSONDecoder().decode(APIErrorResponse.self, from: data)
                errorMessage = apiError?.error ?? "Something went wrong. Please try again."
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func login(email: String, password: String) async {
        isLoading = true
        errorMessage = nil
        
        defer { isLoading = false }
        
        let url = URL(string: APIEndpoints.login)!
        let requestBody = LoginRequest(email: email, password: password)
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(requestBody)
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                let result = try JSONDecoder().decode(LoginResponse.self, from: data)
                self.accessToken = result.token
                self.isAuthenticated = true

            default:
                let apiError = try? JSONDecoder().decode(APIErrorResponse.self, from: data)
                errorMessage = apiError?.error ?? "Something went wrong. Please try again."
            }
            
        } catch {
            errorMessage = error.localizedDescription
        }
    }

}
