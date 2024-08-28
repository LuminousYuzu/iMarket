//
//  SearchResultsView.swift
//  iMarket
//
//  Created by Kyle Liu on 2024/8/27.
//

import SwiftUI


struct SearchResultsView: View {
    @Binding var searchText: String
    var productService: ProductService

    var body: some View {
        List {
            if filteredProducts.isEmpty {
                Text("No Results")
            } else {
                ForEach(filteredProducts) { product in
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        HStack {
                            AsyncImage(url: URL(string: product.thumbnail)) { image in
                                image.resizable()
                            } placeholder: {
                                Color.gray
                            }
                            .frame(width: 40, height: 40)
                            .cornerRadius(8)

                            VStack(alignment: .leading) {
                                Text(product.title)
                                    .font(.headline)
                                Text(product.category.capitalized)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
        }
    }

    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return []
        } else {
            return productService.products.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
}
