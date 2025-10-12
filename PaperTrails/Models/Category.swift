//
//  Category.swift
//  PaperTrails
//
//  Created by Saimur Rashid on 10/3/25.
//

import Foundation

struct Category: Identifiable {
    
    let id: String
    var name: String
    var description: String?
    let documentTypeId: Int?
    var documentCount: Int = 0 
    
    init(from response: CategoryResponse) {
            self.id = response.id
            self.name = response.name
            self.description = response.description
            self.documentTypeId = response.documentTypeId
            self.documentCount = 0 // default, can be updated later
        }
}



