//
//  Config.swift
//  PaperTrails
//
//  Created by Saimur Rashid on 10/7/25.
//

import Foundation


struct Config {
    static let baseURL: String = ProcessInfo.processInfo.environment["API_BASE_URL"] ?? ""
}
