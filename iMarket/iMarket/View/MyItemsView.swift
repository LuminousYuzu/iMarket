//
//  MyItemsView.swift
//  iMarket
//
//  Created by Kyle Liu on 2024/8/26.
//

import SwiftUI

struct MyItemsView: View {
    @EnvironmentObject var favoritesService: FavoritesService

    var body: some View {
        NavigationView {
            List(favoritesService.favoriteItems) { product in
                ProductRowView(product: product)
            }
            .navigationTitle("My Items")
        }
    }
}

