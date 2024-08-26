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
                    Image(systemName: "carrot.fill") // Replace with your custom icon
                    Text("Products")
                }
                .environmentObject(favoritesService)  // Inject here

            MyItemsView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("My Items")
                }
                .environmentObject(favoritesService)  // Inject here

            CartView()
                .tabItem {
                    Image(systemName: "cart")
                    Text("Cart")
                }
        }
        .environmentObject(favoritesService)  // Inject globally here
    }
}


struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
