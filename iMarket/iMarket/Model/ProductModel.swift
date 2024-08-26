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
    let description: String
    let category: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let tags: [String]
    let brand: String?  // Made optional
    let sku: String?
    let weight: Double
    let dimensions: Dimensions
    let warrantyInformation: String?
    let shippingInformation: String?
    let availabilityStatus: String
    let reviews: [Review]
    let returnPolicy: String?
    let minimumOrderQuantity: Int?
    let meta: Meta?
    let thumbnail: String
    let images: [String]
}

struct Dimensions: Decodable {
    let width: Double
    let height: Double
    let depth: Double
}

struct Review: Decodable {
    let rating: Int
    let comment: String
    let date: String // Can be converted to a Date if needed
    let reviewerName: String
    let reviewerEmail: String
}

struct Meta: Decodable {
    let createdAt: String
    let updatedAt: String
    let barcode: String?
    let qrCode: String?
}



