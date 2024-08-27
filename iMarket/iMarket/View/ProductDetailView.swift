//
//  ProductDetailView.swift
//  iMarket
//
//  Created by Kyle Liu on 2024/8/26.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @EnvironmentObject var favoritesService: FavoritesService
    @EnvironmentObject var cartService: CartService
    @State private var sortOption: SortOption = .highestToLowest

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Product Image
                AsyncImage(url: URL(string: product.thumbnail)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Color.gray
                        .frame(height: 300)
                }
                .frame(height: 300)
                .cornerRadius(10)
                .padding(.horizontal)

                // Product Title and Rating
                VStack(alignment: .leading, spacing: 5) {
                    Text(product.title)
                        .font(.title2)
                        .fontWeight(.bold)

                    HStack(spacing: 5) {
                        // Display stars based on the rating
                        ForEach(0..<5) { index in
                            Image(systemName: index < Int(product.rating) ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                        }

                        Text(String(format: "%.1f", product.rating))
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        Text("(\(product.reviews.count))")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal)

                // Price and Availability
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.horizontal)

                Text(product.availabilityStatus)
                    .font(.subheadline)
                    .foregroundColor(product.stock > 0 ? .green : .red)
                    .padding(.horizontal)

                // Location (Fixed value for now)
                Text("at Cupertino")
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .padding(.horizontal)

                // Add to Cart Button and Favorite Button
                HStack {
                    Button(action: {
                        cartService.addToCart(product)
                    }) {
                        Text("Add to Cart")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    Button(action: {
                        favoritesService.toggleFavorite(product)
                    }) {
                        Image(systemName: favoritesService.isFavorite(product) ? "heart.fill" : "heart")
                            .foregroundColor(favoritesService.isFavorite(product) ? .red : .gray)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(30)
                    }
                }
                .padding(.horizontal)

                // Description Section
                VStack(alignment: .leading, spacing: 5) {
                    Text("Description")
                        .font(.headline)
                        .padding(.top)

                    Text(product.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)

                // Reviews Section with Sorting
                if !product.reviews.isEmpty {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Reviews")
                                .font(.headline)

                            Spacer()

                            // Sorting Button
                            Menu {
                                Button(action: {
                                    sortOption = .highestToLowest
                                }) {
                                    Label("Highest to Lowest", systemImage: sortOption == .highestToLowest ? "checkmark" : "")
                                }
                                Button(action: {
                                    sortOption = .lowestToHighest
                                }) {
                                    Label("Lowest to Highest", systemImage: sortOption == .lowestToHighest ? "checkmark" : "")
                                }
                                Button(action: {
                                    sortOption = .newestToOldest
                                }) {
                                    Label("Newest to Oldest", systemImage: sortOption == .newestToOldest ? "checkmark" : "")
                                }
                                Button(action: {
                                    sortOption = .oldestToNewest
                                }) {
                                    Label("Oldest to Newest", systemImage: sortOption == .oldestToNewest ? "checkmark" : "")
                                }
                            } label: {
                                HStack {
                                    Image(systemName: "arrow.up.arrow.down")
                                    Text("Sort")
                                }
                                .font(.subheadline)
                                .foregroundColor(.blue)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal)

                        ForEach(sortedReviews, id: \.reviewerEmail) { review in
                            VStack(alignment: .leading, spacing: 5) {
                                HStack {
                                    Text(review.reviewerName)
                                        .font(.subheadline)
                                        .fontWeight(.bold)

                                    Spacer()

                                    Text(review.date)
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }

                                HStack(spacing: 5) {
                                    ForEach(0..<5) { index in
                                        Image(systemName: index < review.rating ? "star.fill" : "star")
                                            .foregroundColor(.yellow)
                                    }
                                }

                                Text(review.comment)
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top, 10)
                }

                Spacer()
            }
            .padding(.vertical)
        }
        .navigationTitle(product.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    // Computed property to return sorted reviews
    var sortedReviews: [Review] {
        switch sortOption {
        case .highestToLowest:
            return product.reviews.sorted { $0.rating > $1.rating }
        case .lowestToHighest:
            return product.reviews.sorted { $0.rating < $1.rating }
        case .newestToOldest:
            return product.reviews.sorted { $0.date > $1.date }
        case .oldestToNewest:
            return product.reviews.sorted { $0.date < $1.date }
        }
    }
}

// Enum for sorting options
enum SortOption {
    case highestToLowest
    case lowestToHighest
    case newestToOldest
    case oldestToNewest
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleProduct = Product(
            id: 1,
            title: "Sample Product",
            description: "This is a sample product description.",
            category: "Category",
            price: 9.99,
            discountPercentage: 0.0,
            rating: 4.5,
            stock: 10,
            tags: [],
            brand: "Brand",
            sku: "SKU",
            weight: 0.5,
            dimensions: Dimensions(width: 10.0, height: 20.0, depth: 5.0),
            warrantyInformation: "1 Year Warranty",
            shippingInformation: "Ships in 2 days",
            availabilityStatus: "In Stock",
            reviews: [
                Review(rating: 5, comment: "Great product!", date: "2024-08-26", reviewerName: "John Doe", reviewerEmail: "john.doe@example.com"),
                Review(rating: 3, comment: "It's okay.", date: "2024-07-15", reviewerName: "Jane Smith", reviewerEmail: "jane.smith@example.com"),
                Review(rating: 1, comment: "Not good at all.", date: "2024-06-10", reviewerName: "Alice Johnson", reviewerEmail: "alice.johnson@example.com")
            ],
            returnPolicy: "30 days return policy",
            minimumOrderQuantity: 1,
            meta: nil,
            thumbnail: "https://example.com/product.jpg",
            images: []
        )

        ProductDetailView(product: sampleProduct)
            .environmentObject(FavoritesService())  
    }
}

