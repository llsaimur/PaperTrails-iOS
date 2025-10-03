//
//  Category.swift
//  PaperTrails
//
//  Created by Saimur Rashid on 10/3/25.
//

import Foundation

struct Category: Identifiable {
    let id = UUID()
    let name: String
    let documentCount: Int
}
