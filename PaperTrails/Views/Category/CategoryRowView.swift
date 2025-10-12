//
//  CategoryRowView.swift
//  PaperTrails
//
//  Created by Saimur Rashid on 10/3/25.
//

import SwiftUI

struct CategoryRowView: View {
    var category: Category
    
    var body: some View {
        HStack {
            Image(systemName: "folder.fill")
                .foregroundColor(.blue)
            Text(category.name)
                .font(.headline)
            Spacer()
            Text("\(category.documentCount)")
                .foregroundColor(.gray)
        }
        .padding(.vertical, 6)
    }
}


