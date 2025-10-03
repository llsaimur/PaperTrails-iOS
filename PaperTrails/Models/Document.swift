//
//  Document.swift
//  PaperTrails
//
//  Created by Saimur Rashid on 10/3/25.
//

import Foundation
import UIKit

struct Document: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let attachments: Int
    let description: String
    let image: UIImage?
    let pdfURL: URL?
}
