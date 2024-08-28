//
//  TabView.swift
//  iMarket
//
//  Created by Kyle Liu on 2024/8/26.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var favoritesService = FavoritesService()
    @StateObject private var cartService = CartService()  

    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "carrot.fill")
                    Text("Products")
                }
                .environmentObject(favoritesService)
                .environmentObject(cartService)

            MyItemsView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("My Items")
                }
                .environmentObject(favoritesService)

            CartView()
                .tabItem {
                    Image(systemName: "cart")
                    Text("Cart")
                }
                .environmentObject(cartService)
        }
        .environmentObject(favoritesService)
        .environmentObject(cartService)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}







