//
//  MyItemsView.swift
//  iMarket
//
//  Created by Kyle Liu on 2024/8/26.
//

import SwiftUI

import SwiftUI

struct MyItemsView: View {
    @EnvironmentObject var favoritesService: FavoritesService

    var body: some View {
        NavigationView {
            if favoritesService.favoriteItems.isEmpty {
                Text("No favorite items yet.")
                    .foregroundColor(.gray)
                    .navigationTitle("My Items")
            } else {
                List(favoritesService.favoriteItems) { product in
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        ProductRowView(product: product)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .navigationTitle("My Items")
            }
        }
    }
}

struct MyItemsView_Previews: PreviewProvider {
    static var previews: some View {
        MyItemsView()
            .environmentObject(FavoritesService()) 
    }
}

