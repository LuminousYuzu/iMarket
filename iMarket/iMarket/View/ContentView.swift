//
//  ContentView.swift
//  iMarket
//
//  Created by Kyle Liu on 2024/8/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var productService = ProductService()
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                SearchBar(text: $searchText)
                    .padding(.top, 10)
                    .padding(.horizontal)
                
                // Product List
                List(filteredProducts) { product in
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        ProductRowView(product: product)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .onAppear {
                productService.fetchProducts()
            }
            .navigationTitle("Products")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return productService.products
        } else {
            return productService.products.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

// Product Row View
struct ProductRowView: View {
    let product: Product

    var body: some View {
        HStack {
            // Thumbnail
            AsyncImage(url: product.thumbnail) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: 60, height: 60)
            .cornerRadius(8)

            VStack(alignment: .leading, spacing: 5) {
                // Title
                Text(product.title)
                    .font(.headline)
                    .lineLimit(1)

                // Price and Category
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(product.category)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(EdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 5))
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }

            Spacer()

            // Add to Cart Button
            Button(action: {
                // Add to cart action
            }) {
                Text("Add to Cart")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                    .background(Color.blue)
                    .cornerRadius(5)
            }

            // Favorite Icon
            Button(action: {
                // Favorite action
            }) {
                Image(systemName: "heart")
                    .foregroundColor(.gray)
            }
            .padding(.leading, 5)
        }
        .padding(.vertical, 5)
    }
}

struct ProductRowView_Previews: PreviewProvider {
    static var previews: some View {
        ProductRowView(product: Product(
            id: 1,
            title: "Essence Mascara Lash Princess",
            price: 9.99,
            thumbnail: URL(string: "https://example.com/mascara.jpg"),
            description: "High-quality mascara.",
            discountPercentage: 10.0,
            rating: 4.5,
            stock: 100,
            brand: "Essence",
            category: "Beauty"
        ))
        .previewLayout(.sizeThatFits)
        .padding()
    }
}

struct SearchBar: UIViewRepresentable {
    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let productService = ProductService(products: [
            Product(
                id: 1,
                title: "Essence Mascara Lash Princess",
                price: 9.99,
                thumbnail: URL(string: "https://example.com/mascara.jpg"),
                description: "High-quality mascara.",
                discountPercentage: 10.0,
                rating: 4.5,
                stock: 100,
                brand: "Essence",
                category: "Beauty"
            ),
            Product(
                id: 2,
                title: "Eyeshadow Palette with Mirror",
                price: 19.99,
                thumbnail: URL(string: "https://example.com/eyeshadow.jpg"),
                description: "A beautiful palette of eyeshadows.",
                discountPercentage: 15.0,
                rating: 4.8,
                stock: 50,
                brand: "BeautyBrand",
                category: "Beauty"
            )
        ])
        return ContentView()
            .environmentObject(productService)
    }
}
