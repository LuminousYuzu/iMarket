//
//  ProductService.swift
//  iMarket
//
//  Created by Kyle Liu on 2024/8/26.
//

import Foundation
import Combine
struct ProductResponse: Decodable {
    let products: [Product]
}

class ProductService: ObservableObject {
    @Published var products: [Product]

    init(products: [Product] = []) {
        self.products = products
    }

    func fetchProducts() {
        guard let url = URL(string: "https://dummyjson.com/products") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    // Decode the response into a ProductResponse object
                    let productResponse = try JSONDecoder().decode(ProductResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.products = productResponse.products
                    }
                } catch {
                    print("Error decoding: \(error)")
                }
            }
        }.resume()
    }
}

