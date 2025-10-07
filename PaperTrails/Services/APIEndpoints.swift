//
//  APIEndpoints.swift
//  PaperTrails
//
//  Created by Saimur Rashid on 10/7/25.
//


struct APIEndpoints {
    static var register: String { Config.baseURL + "/users/register" }
    static var login: String { Config.baseURL + "/users/login" }
}
