//
//  TabView.swift
//  iMarket
//
//  Created by Kyle Liu on 2024/8/26.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var favoritesService = FavoritesService()

    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "carrot.fill")
                    Text("Products")
                }
                .environmentObject(favoritesService)  // Inject FavoritesService here

            MyItemsView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("My Items")
                }
                .environmentObject(favoritesService)  // Inject FavoritesService here

            CartView()
                .tabItem {
                    Image(systemName: "cart")
                    Text("Cart")
                }
                .environmentObject(favoritesService)  // Inject FavoritesService here
        }
        .environmentObject(favoritesService)  // Inject FavoritesService here
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}



