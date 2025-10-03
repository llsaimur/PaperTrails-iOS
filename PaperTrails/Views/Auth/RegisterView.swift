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
                TextField("Email", text: $email)
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
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                Spacer()
                
                // Register Button
                Button(action: {
                    
                    print("Register tapped")
                }) {
                    Text("Register")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(5)
                }
                .padding(.top, 10)
                
                // Sign in with Apple
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
                
                HStack {
                    Text("Already have an account?").foregroundColor(.gray)
                    NavigationLink("Log In", destination: LoginView()).foregroundColor(.black)
                }
            }
            .padding()
        }
    }
}

#Preview {
    RegisterView()
}
