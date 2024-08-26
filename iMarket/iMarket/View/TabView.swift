//
//  TabView.swift
//  iMarket
//
//  Created by Kyle Liu on 2024/8/26.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var productService = ProductService()

    var body: some View {
        TabView {
            // Products Tab
            ContentView()
                .tabItem {
                    Label("Products", systemImage: "cart.fill")
                }
                .environmentObject(productService)
            
            // My Items Tab
            NavigationView {
                VStack {
                    Text("My Items View")
                        .font(.title)
                        .padding()
                    
                    // Placeholder content for My Items
                    List {
                        Text("Favorite Item 1")
                        Text("Favorite Item 2")
                        // Add more items as needed
                    }
                }
                .navigationTitle("My Items")
            }
            .tabItem {
                Label("My Items", systemImage: "heart.fill")
            }
            
            // Cart Tab
            NavigationView {
                VStack {
                    Text("Cart View")
                        .font(.title)
                        .padding()
                    
                    // Placeholder content for Cart
                    List {
                        Text("Cart Item 1")
                        Text("Cart Item 2")
                        // Add more items as needed
                    }
                }
                .navigationTitle("Cart")
            }
            .tabItem {
                Label("Cart", systemImage: "cart.fill")
            }
        }
    }
}


