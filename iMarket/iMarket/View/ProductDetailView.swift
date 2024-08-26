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
        VStack {
            AsyncImage(url: product.thumbnail) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .aspectRatio(contentMode: .fit)
            .frame(height: 300)

            Text(product.title)
                .font(.title)
                .padding(.top)
            Text("$\(product.price, specifier: "%.2f")")
                .font(.title2)
                .foregroundColor(.gray)
                .padding(.top)

            Text(product.description)
                .padding()

            Spacer()

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
            .padding()
        }
        .navigationTitle(product.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

