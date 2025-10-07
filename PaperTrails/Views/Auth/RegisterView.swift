//
//  RegisterView.swift
//  PaperTrails
//
//  Created by Saimur Rashid on 9/30/25.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var showPassword = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                
                // Title
                Text("Create Account")
                    .font(.system(size: 32, weight: .bold))
                    .padding(.bottom, 10)
                
                // First Name
                TextField("First Name", text: $firstName)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .autocapitalization(.words)
                    .disableAutocorrection(true)
                
                // Last Name
                TextField("Last Name", text: $lastName)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .autocapitalization(.words)
                    .disableAutocorrection(true)
                
                // Email
                TextField("email@example.com", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                // Password
                ZStack(alignment: .trailing) {
                    Group {
                        if showPassword {
                            TextField("Password (min 8 chars)", text: $password)
                        } else {
                            SecureField("Password (min 8 chars)", text: $password)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    
                    Button(action: { showPassword.toggle() }) {
                        Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.gray)
                            .padding(.trailing, 12)
                    }
                }
                
                Spacer()
                
                // Register button
                Button(action: {
                    if let validationError = validateAll() {
                        alertMessage = validationError
                        showAlert = true
                        return
                    }
                    
                    Task {
                        await authViewModel.register(
                            firstName: firstName,
                            lastName: lastName,
                            email: email,
                            password: password
                        )
                        
                        // If backend returned error, show alert
                        if let backendError = authViewModel.errorMessage {
                            alertMessage = backendError
                            showAlert = true
                        }
                    }
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(isFormValid ? Color.black : Color.gray)
                            .frame(height: 50)
                        
                        if authViewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            Text("Register")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                        }
                    }
                }
                .padding(.top, 10)
                .disabled(authViewModel.isLoading)
                
                // Sign in with Apple (optional)
                Button(action: {
                    // Handle Apple Sign-In
                }) {
                    HStack {
                        Image(systemName: "applelogo")
                            .font(.title2)
                        Text("Register with Apple")
                            .fontWeight(.semibold)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Go to Login
                HStack {
                    Text("Already have an account?").foregroundColor(.gray)
                    NavigationLink("Log In", destination: LoginView())
                        .foregroundColor(.black)
                }
            }
            .alert("Registration Failed", isPresented: $showAlert) {
                Button("OK", role: .cancel) {
                    authViewModel.errorMessage = nil
                }
            } message: {
                Text(alertMessage)
            }
            .padding()
            .navigationDestination(isPresented: $authViewModel.registrationSuccess) {
                LoginView()
            }
            .onAppear {
                authViewModel.errorMessage = nil
                authViewModel.registrationSuccess = false
            }
        }
    }
    
    private func validateAll() -> String? {
        if !isFormValid {
            return "All fields are required."
        } else if !isValidEmail(email) {
            return "Invalid email address."
        } else if password.count < 8 {
            return "Password must be at least 8 characters."
        }
        return nil
    }
    
    private var isFormValid: Bool {
        !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && !password.isEmpty
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }
}

#Preview {
    RegisterView()
        .environmentObject(AuthViewModel())
}
