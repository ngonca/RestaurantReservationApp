//
//  MexicanRestaurantsView.swift
//  DineReserve
//
//  Created by Nazli Gonca on 14.05.2025.
//

import SwiftUI

struct MexicanRestaurantsView: View {
    @State private var mexicanRestaurants: [RestaurantResponseModel] = []

    var body: some View {
        VStack {
            // Restoranlar Listesi
            List(mexicanRestaurants, id: \.id) { restaurant in
                RestaurantCard(restaurant: restaurant)
            }
            .onAppear {
                fetchMexicanRestaurants()
            }

            Spacer()
        }
        .navigationTitle("Mexican Restaurants")
    }

    // Mexican restoranlarını çeker
    func fetchMexicanRestaurants() {
        NetworkManager.shared.request(endpoint: CategoryAPI.fetchRestaurantsByCategory(3)) { (result: Result<[RestaurantResponseModel], APIError>) in
            switch result {
            case .success(let data):
                mexicanRestaurants = data
            case .failure(let error):
                print("Mexican restoranları alınamadı: \(error)")
            }
        }
    }
}
