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
        // Assuming this is the calculation logic
        return cartItems.reduce(0) { $0 + $1.price }
    }

    var subtotal: Double {
        // Example subtotal calculation
        return totalPrice
    }

    var savings: Double {
        // Example savings calculation, adjust logic as needed
        return 0.0
    }

    var taxes: Double {
        // Example taxes calculation, assuming a 1.5% tax rate
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

