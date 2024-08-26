//
//  ProductModel.swift
//  iMarket
//
//  Created by Kyle Liu on 2024/8/26.
//

import Foundation


struct Product: Identifiable, Decodable {
    let id: Int
    let title: String
    let price: Double
    let thumbnail: URL?
    let description: String
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String
    let category: String
}



