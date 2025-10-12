//
//  LoginView.swift
//  PaperTrails
//
//  Created by Saimur Rashid on 9/30/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var showPassword = false
    @State private var showAlert = false
    @State private var navigateToRegister = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                
                Text("PaperTrails").font(.system(size: 48, weight: .bold))
                
                // Email field
                TextField("Email", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
                    .overlay(RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                // Password field with show/hide toggle
                HStack {
                    if showPassword {
                        TextField("Password", text: $password)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    } else {
                        SecureField("Password", text: $password)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }

                    Button(action: { showPassword.toggle() }) {
                        Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .overlay(RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1))

                
                // Forgot password
                HStack {
                    Spacer()
                    Button("Forgot password?") {
                        print("Forgot password tapped")
                    }
                    .font(.footnote)
                    .foregroundColor(.black)
                }
                
                Spacer()
                
                // Login button
                Button(action: {
                    Task {
                        await authViewModel.login(email: email, password: password)
                        if let _ = authViewModel.errorMessage {
                            showAlert = true
                        }
                        print(authViewModel.accessToken)
                    }
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.black)
                            .frame(height: 50)
                        
                        if authViewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            Text("Log In")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                        }
                    }
                }
                .padding(.top, 10)
                .disabled(authViewModel.isLoading)

                
                // Apple Sign-In
                Button(action: {}) {
                    HStack {
                        Image(systemName: "applelogo")
                            .font(.title2)
                        Text("Log in with Apple")
                            .fontWeight(.semibold)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
                }
                .padding(.horizontal)
                
                Spacer()
                
                HStack {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0.4))
                    Text("OR")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0.4))
                }
                .padding(.vertical, 10)
                
                // Navigation to MainView after successful login
                NavigationLink(
                    destination: MainView(authViewModel: authViewModel)
                        .environmentObject(authViewModel),
                    isActive: $authViewModel.isAuthenticated
                ) {
                    EmptyView()
                }


                
                HStack {
                    Text("Don't have an account?").foregroundColor(.gray)
                    NavigationLink("Register", destination: RegisterView()).foregroundColor(.black)
                }
            }
            .padding()
            .onAppear(){
                authViewModel.errorMessage = nil
            }
        }
        .alert("We couldn't find your account", isPresented: $showAlert) {
            Button("Create New Account") {
                navigateToRegister = true
            }
            Button("Try Again", role: .cancel) { }
        } message: {
            Text("Check your email or password and try again.")
        }
        .navigationDestination(isPresented: $navigateToRegister) {
            RegisterView()
        }
    }
}



#Preview {
    LoginView()
}
