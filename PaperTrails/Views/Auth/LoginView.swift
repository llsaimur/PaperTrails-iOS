//
//  LoginView.swift
//  PaperTrails
//
//  Created by Saimur Rashid on 9/30/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var navigateToMain = false
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                Spacer()
                
                HStack{
                    Text("PaperTrails").font(.system(size: 48, weight: .bold))
                }
                .padding()
                
                // email field
                TextField("Email", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
                    .overlay(RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                // password field
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
                    .overlay(RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                // forgot password field
                HStack {
                    Spacer()
                    Button(action:
                            {
                        print("Forgot password tapped")
                    })
                    {
                        Text("Forgot password?")
                            .font(.footnote)
                            .foregroundColor(.black)
                    }
                }
                
                Spacer()
                
                // login button
                Button(action: {
                    navigateToMain = true
                    print("Login tapped")
                }){
                    Text("Log In")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(5)
                }
                .padding(.top, 10)
                
                Button(action: {
                    // TODO: Handle Apple Sign-In
                }) {
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
                
                NavigationLink(destination: MainView(), isActive: $navigateToMain) {
                                   EmptyView()
                               }
                
                HStack{
                    Text("Don't have an account?").foregroundColor(.gray)
                    NavigationLink("Register", destination: RegisterView()).foregroundColor(.black)
                }
            }
            .padding()
        }
    }
}


#Preview {
    LoginView()
}
