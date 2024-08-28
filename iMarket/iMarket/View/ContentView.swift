//
//  ContentView.swift
//  iMarket
//
//  Created by Kyle Liu on 2024/8/26.
//

import SwiftUI


struct ContentView: View {
    @StateObject private var productService = ProductService()
    @EnvironmentObject var favoritesService: FavoritesService
    @EnvironmentObject var cartService: CartService

    @State private var searchText = ""
    @State private var isEditing = false

    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                SearchBar(text: $searchText, isEditing: $isEditing)
                    .padding(.horizontal)

                if isEditing {
                    // Show search results when editing
                    SearchResultsView(searchText: $searchText, productService: productService)
                } else {
                    // Product List
                    List(filteredProducts) { product in
                        NavigationLink(destination: ProductDetailView(product: product)) {
                            ProductRowView(product: product)
                        }
                        .buttonStyle(PlainButtonStyle())  // Ensures no interference with buttons
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .onAppear {
                productService.fetchProducts()
            }
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

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    @Binding var isEditing: Bool

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        @Binding var isEditing: Bool

        init(text: Binding<String>, isEditing: Binding<Bool>) {
            _text = text
            _isEditing = isEditing
        }

        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            isEditing = true
            searchBar.becomeFirstResponder() // Ensure the search bar becomes the first responder
        }

        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            isEditing = false
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
            isEditing = false
        }

        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder() // Hide the keyboard on cancel
            isEditing = false
            text = ""
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, isEditing: $isEditing)
    }

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "What are you looking for?"
        searchBar.backgroundImage = UIImage()
        searchBar.showsCancelButton = true // Show the cancel button to easily dismiss the keyboard

        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ProductService())
            .environmentObject(FavoritesService())
            .environmentObject(CartService())  
    }
}

