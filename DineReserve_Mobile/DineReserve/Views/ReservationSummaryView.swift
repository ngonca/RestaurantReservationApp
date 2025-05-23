//
//  ReservationSummaryView.swift
//  DineReserve
//
//  Created by Nazli Gonca on 13.03.2025.
//

//
//  ReservationSummaryView.swift
//  DineReserve
//
//  Created by Nazlı Gonca on 5.03.2025.
//

import SwiftUI

// MARK: - Reservation Summary Page
struct ReservationSummaryView: View {
    var restaurantName: String
    var reservationTime: String
    var selectedMenuItems: [MenuItem]
    var totalPrice: Double
    
    @State private var navigateToPayment = false

    var body: some View {
        VStack(spacing: 20) {
            // Page Title
            Text("Reservation Summary")
                .font(.title)
                .fontWeight(.bold)

            // Restaurant Info
            VStack(alignment: .leading, spacing: 8) {
                Text("📍 \(restaurantName)")
                    .font(.headline)
                
                Text("🕒 \(reservationTime)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))

            // Selected Menu Items
            VStack(alignment: .leading, spacing: 10) {
                Text("🍽 Selected Menu")
                    .font(.title2)
                    .fontWeight(.semibold)

                ForEach(selectedMenuItems) { item in
                    HStack {
                        Text("\(item.name)")
                        Spacer()
                        Text("$\(String(format: "%.2f", item.price))")
                            .fontWeight(.bold)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
            }
            .padding()

            // Total Price
            Text("Total: $\(String(format: "%.2f", totalPrice))")
                .font(.title2)
                .fontWeight(.bold)

            // Proceed to Payment Button
            Button(action: {
                navigateToPayment = true
            }) {
                Text("Proceed to Payment")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 3)
            }
            .padding()

            // Navigation to Payment Page
        //    NavigationLink(destination: PaymentView(totalAmount: totalPrice), isActive: $navigateToPayment) {
         //       EmptyView()
           // }
        }
        .padding()
        .navigationTitle("Summary")
    }
}

// MARK: - Sample Data Model
struct MenuItem: Identifiable {
    var id = UUID()
    var name: String
    var price: Double
}

// MARK: - Preview
struct ReservationSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ReservationSummaryView(
                restaurantName: "Gourmet Bistro",
                reservationTime: "March 20, 2025 - 7:00 PM",
                selectedMenuItems: [
                    MenuItem(name: "Steak", price: 25.99),
                    MenuItem(name: "Pasta", price: 18.49),
                    MenuItem(name: "Wine", price: 12.99)
                ],
                totalPrice: 57.47
            )
        }
    }
}
