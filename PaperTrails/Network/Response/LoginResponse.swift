//
//  LoginResponse.swift
//  PaperTrails
//
//  Created by Saimur Rashid on 10/7/25.
//

import Foundation

struct LoginResponse: Codable {
    let name: String
    let email: String
    let token: String
    let expiresIn: Int
}
