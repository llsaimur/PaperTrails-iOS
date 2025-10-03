//
//  WelcomeView.swift
//  PaperTrails
//
//  Created by Saimur Rashid on 10/2/25.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                HStack{
                    Text("PaperTrails").font(.system(size: 48, weight: .bold))
                }
                HStack{
                    Text("Find what you need, when you need it.")
                }
                Spacer()
                
                Image("PaperTrailsHomePage").resizable().aspectRatio(contentMode: .fit)
                
                Spacer()
                
                NavigationLink(destination: LoginView()) {
                                    Text("Login")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.black)
                                        .cornerRadius(8)
                                }
                                .padding(.horizontal, 40)
                
                Spacer()
                
                
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
    WelcomeView()
}
