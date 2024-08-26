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
    @State private var searchText = ""


    
    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                SearchBar(text: $searchText)
                    
                    .padding(.horizontal)
                
                // Product List
                List(filteredProducts) { product in
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        ProductRowView(product: product)
                    }
                    .buttonStyle(PlainButtonStyle())  // Ensures no interference with buttons
                }
                .listStyle(PlainListStyle())
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

        // Customize the search bar appearance
        searchBar.backgroundImage = UIImage()  // Removes the background line
        searchBar.placeholder = "What are you looking for?"  // Set the placeholder text

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
    }
}

