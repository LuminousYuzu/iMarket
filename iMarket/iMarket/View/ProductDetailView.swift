//
//  ProductDetailView.swift
//  iMarket
//
//  Created by Kyle Liu on 2024/8/26.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product

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
                        // Handle adding to cart
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
                        // Handle favoriting the product
                    }) {
                        Image(systemName: "heart")
                            .foregroundColor(.gray)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
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

                // Reviews Section
                if !product.reviews.isEmpty {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Reviews")
                                .font(.headline)

                            Spacer()

                            Button(action: {
                                // Handle sorting reviews
                            }) {
                                HStack {
                                    Image(systemName: "arrow.up.arrow.down")
                                    Text("Sort")
                                }
                                .font(.subheadline)
                                .foregroundColor(.blue)
                            }
                        }
                        .padding(.horizontal)

                        ForEach(product.reviews, id: \.reviewerEmail) { review in
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
}
