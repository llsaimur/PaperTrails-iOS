//
//  AuthViewModel.swift
//  PaperTrails
//
//  Created by Saimur Rashid on 9/30/25.
//

import Foundation
import SwiftUI

class AuthViewModel : ObservableObject {
    @Published var isLoggedIn : Bool = false
    
    func login(email: String, password: String){
        if !email.isEmpty && !password.isEmpty{
            isLoggedIn = true
        }
    }
    
    func logout(){
        isLoggedIn = false;
    }
    
}

