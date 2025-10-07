//
//  RegisterRequest.swift
//  PaperTrails
//
//  Created by Saimur Rashid on 10/7/25.
//


struct RegisterRequest: Codable {
    let name: String
    let email: String
    let password: String
}