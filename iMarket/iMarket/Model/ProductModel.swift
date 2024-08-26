//
//  ProductModel.swift
//  iMarket
//
//  Created by Kyle Liu on 2024/8/26.
//

import Foundation

struct Product: Identifiable, Codable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let discountPercentage: Double?
    let rating: Double?
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: URL
}
