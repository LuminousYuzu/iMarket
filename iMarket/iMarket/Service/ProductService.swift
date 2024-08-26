//
//  ProductService.swift
//  iMarket
//
//  Created by Kyle Liu on 2024/8/26.
//

import Foundation

class ProductService: ObservableObject {
    @Published var products: [Product] = []
    
    func fetchProducts() {
        guard let url = URL(string: "https://dummyjson.com/products") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let productResponse = try JSONDecoder().decode([String: [Product]].self, from: data)
                    DispatchQueue.main.async {
                        self.products = productResponse["products"] ?? []
                    }
                } catch {
                    print("Error decoding: \(error)")
                }
            }
        }.resume()
    }
}

