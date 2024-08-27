//
//  CartView.swift
//  iMarket
//
//  Created by Kyle Liu on 2024/8/26.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartService: CartService
    @State private var isExpanded: Bool = false  

    var body: some View {
        NavigationView {
            VStack {
                if cartService.cartItems.isEmpty {
                    Spacer()
                    Text("Your cart is empty.")
                        .foregroundColor(.gray)
                    Spacer()
                } else {
                    List {
                        ForEach(cartService.cartItems) { product in
                            HStack {
                                NavigationLink(destination: ProductDetailView(product: product)) {
                                    HStack {
                                        // Display product thumbnail
                                        AsyncImage(url: URL(string: product.thumbnail)) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 50, height: 50)
                                                .cornerRadius(5)
                                        } placeholder: {
                                            Color.gray
                                                .frame(width: 50, height: 50)
                                                .cornerRadius(5)
                                        }

                                        VStack(alignment: .leading, spacing: 5) {
                                            Text(product.title)
                                                .font(.headline)
                                                .lineLimit(1)

                                            Text("$\(product.price, specifier: "%.2f")")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                }
                                Spacer()

                                // Remove from cart button
                                Button(action: {
                                    cartService.removeFromCart(product)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                                .buttonStyle(BorderlessButtonStyle()) // Prevents triggering the NavigationLink
                            }
                            .padding(.vertical, 5)
                        }
                    }
                    .listStyle(PlainListStyle())

                    // Expandable Order Summary
                    VStack {
                        HStack {
                            Text(String(format: "$%.2f total", cartService.totalPrice))
                                .font(.title3)
                                .fontWeight(.bold)
                            Spacer()
                            Button(action: {
                                withAnimation {
                                    isExpanded.toggle()
                                }
                            }) {
                                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(10)
                        .padding([.leading, .trailing, .bottom])

                        if isExpanded {
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Text("Subtotal")
                                    Spacer()
                                    Text(String(format: "$%.2f", cartService.subtotal))
                                }
                                HStack {
                                    Text("Savings")
                                    Spacer()
                                    Text(String(format: "$%.2f", cartService.savings))
                                }
                                HStack {
                                    Text("Taxes")
                                    Spacer()
                                    Text(String(format: "$%.2f", cartService.taxes))
                                }
                            }
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(10)
                            .padding([.leading, .trailing, .bottom])
                        }
                    }
                }
            }
            .navigationTitle("Cart")
            .toolbar {
                if !cartService.cartItems.isEmpty {
                    // Clear Cart Button
                    Button(action: {
                        cartService.clearCart()
                    }) {
                        Text("Clear Cart")
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartService())
    }
}




