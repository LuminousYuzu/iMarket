//
//  CartService.swift
//  iMarket
//
//  Created by Kyle Liu on 2024/8/26.
//

import Foundation
import Combine

class CartService: ObservableObject {
    @Published var cartItems: [Product] = []

    var totalPrice: Double {

        return cartItems.reduce(0) { $0 + $1.price }
    }

    var subtotal: Double {

        return totalPrice
    }

    var savings: Double {

        return 0.0
    }

    var taxes: Double {

        return subtotal * 0.015
    }

    func addToCart(_ product: Product) {
        cartItems.append(product)
    }

    func removeFromCart(_ product: Product) {
        cartItems.removeAll { $0.id == product.id }
    }

    func clearCart() {
        cartItems.removeAll()
    }
}

