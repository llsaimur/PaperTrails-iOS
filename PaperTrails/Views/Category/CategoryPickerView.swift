//
//  CategoryPickerView.swift
//  PaperTrails
//
//  Created by Saimur Rashid on 10/3/25.
//

import SwiftUI

struct CategoryPickerView: View {
    @Binding var selectedCategory: String
    
    let categories = ["Tickets", "Bills", "Insurance"]
    
    var body: some View {
        VStack(spacing: 8) {
            ForEach(categories, id: \.self) { category in
                Button(action: {
                    selectedCategory = category
                }) {
                    HStack {
                        Text(category)
                        Spacer()
                        if selectedCategory == category {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(8)
                }
            }
        }
        .padding(.top, 4)
    }
}

#Preview {
    CategoryPickerView(selectedCategory: .constant("Bills"))
}

