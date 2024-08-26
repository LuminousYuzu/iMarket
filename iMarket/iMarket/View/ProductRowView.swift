//
//  ProductRowView.swift
//  iMarket
//
//  Created by Kyle Liu on 2024/8/26.
//

import SwiftUI

// Product Row View
struct ProductRowView: View {
    let product: Product
    @EnvironmentObject var favoritesService: FavoritesService
        

    var body: some View {
        HStack {
            // Thumbnail
            AsyncImage(url: URL(string: product.thumbnail)) { image in
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
                Text(product.category.capitalized)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(EdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 5))
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }

            Spacer()

            // Favorite Icon and Add to Cart Button
            VStack(alignment: .trailing, spacing: 10) {
                Button(action: {
                    favoritesService.toggleFavorite(product)
                }) {
                    Image(systemName: favoritesService.isFavorite(product) ? "heart.fill" : "heart")
                        .foregroundColor(favoritesService.isFavorite(product) ? .red : .gray)
                }

                Button(action: {
                    // Add to cart action
                }) {
                    Text("Add to Cart")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .cornerRadius(5)
                }
            }
        }
        .padding(.vertical, 8)
    }
}

struct ProductRowView_Previews: PreviewProvider {
    static var previews: some View {
        // Create an empty product just for the sake of preview
        let emptyProduct = Product(
            id: 0,
            title: "Sample Product",
            description: "",
            category: "Category",
            price: 0.0,
            discountPercentage: 0.0,
            rating: 0.0,
            stock: 0,
            tags: [],
            brand: nil,
            sku: nil,
            weight: 0.0,
            dimensions: Dimensions(width: 0.0, height: 0.0, depth: 0.0),
            warrantyInformation: nil,
            shippingInformation: nil,
            availabilityStatus: "",
            reviews: [],
            returnPolicy: nil,
            minimumOrderQuantity: nil,
            meta: nil,
            thumbnail: "",
            images: []
        )

        ProductRowView(product: emptyProduct)
            .environmentObject(FavoritesService())  // Inject an empty FavoritesService
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
