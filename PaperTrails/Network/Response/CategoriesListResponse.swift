//
//  CategoriesListResponse.swift
//  PaperTrails
//
//  Created by Saimur Rashid on 10/9/25.
//


struct CategoriesListResponse: Codable {
    let page: Int
    let pageSize: Int
    let totalCount: Int
    let totalPages: Int
    let data: [CategoryResponse]
}

