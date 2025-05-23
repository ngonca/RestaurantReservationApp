//
//  TurkishRestaurantsView.swift
//  DineReserve
//
//  Created by Nazli Gonca on 14.05.2025.
//

import SwiftUI

struct TurkishRestaurantsView: View {
    @State private var turkishRestaurants: [RestaurantResponseModel] = []

    var body: some View {
        VStack {
            // Restoranlar Listesi
            List(turkishRestaurants, id: \.id) { restaurant in
                RestaurantCard(restaurant: restaurant)
            }
            .onAppear {
                fetchTurkishRestaurants()
            }

            Spacer()
        }
        .navigationTitle("Turkish Restaurants")
    }

    // Turkish restoranlarını çeker
    func fetchTurkishRestaurants() {
        NetworkManager.shared.request(endpoint: CategoryAPI.fetchRestaurantsByCategory(2)) { (result: Result<[RestaurantResponseModel], APIError>) in
            switch result {
            case .success(let data):
                turkishRestaurants = data
            case .failure(let error):
                print("Turkish restoranları alınamadı: \(error)")
            }
        }
    }
}
