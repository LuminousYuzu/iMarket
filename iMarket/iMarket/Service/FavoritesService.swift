//
//  FavoritesService.swift
//  iMarket
//
//  Created by Kyle Liu on 2024/8/26.
//

import Foundation
import Combine

class FavoritesService: ObservableObject {
    @Published var favoriteItems: [Product] = []

    func toggleFavorite(_ product: Product) {
        if favoriteItems.contains(where: { $0.id == product.id }) {
            favoriteItems.removeAll(where: { $0.id == product.id })
        } else {
            favoriteItems.append(product)
        }
    }

    func isFavorite(_ product: Product) -> Bool {
        return favoriteItems.contains(where: { $0.id == product.id })
    }
}

