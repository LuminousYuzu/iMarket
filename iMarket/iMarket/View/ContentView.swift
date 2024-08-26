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
                SearchBar(text: $searchText)
                List(filteredProducts) { product in
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        ProductRowView(product: product)
                    }
                }
            }
            .onAppear {
                productService.fetchProducts()
            }
            .navigationTitle("Products")
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

// Preview for ContentView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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

// Preview for SearchBar
struct SearchBar_Previews: PreviewProvider {
    @State static var searchText = "Search term"
    
    static var previews: some View {
        SearchBar(text: $searchText)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

struct ProductRowView: View {
    let product: Product

    var body: some View {
        HStack {
            AsyncImage(url: product.thumbnail) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: 50, height: 50)
            .cornerRadius(8)

            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.headline)
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.subheadline)
            }
        }
    }
}

struct ProductRowView_Previews: PreviewProvider {
    static var previews: some View {
        ProductRowView(product: Product(
            id: 1,
            title: "Sample Product",
            description: "This is a sample product description.",
            price: 19.99,
            discountPercentage: 10.0,
            rating: 4.5,
            stock: 100,
            brand: "Sample Brand",
            category: "Sample Category",
            thumbnail: URL(string: "https://via.placeholder.com/50")!
        ))
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
