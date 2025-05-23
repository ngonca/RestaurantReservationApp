//
//  AsianRestaurantsView.swift
//  DineReserve
//
//  Created by Nazli Gonca on 14.05.2025.
//
import SwiftUI

struct AsianRestaurantsView: View {
    @State private var asianRestaurants: [RestaurantResponseModel] = []

    var body: some View {
        VStack {
            // Restoranlar Listesi
            List(asianRestaurants, id: \.id) { restaurant in
                RestaurantCard(restaurant: restaurant)
            }
            .onAppear {
                fetchAsianRestaurants()
            }

            Spacer()
        }
        .navigationTitle("Asian Restaurants")
    }

    // Italian restoranlarını çeker
    func fetchAsianRestaurants() {
        // Burada, Italian restoranlarını çekecek bir API çağrısı yapılır. Şu an örnek olarak sabit veriler kullanıldı.
        NetworkManager.shared.request(endpoint: CategoryAPI.fetchRestaurantsByCategory(1)) { (result: Result<[RestaurantResponseModel], APIError>) in
            switch result {
            case .success(let data):
                asianRestaurants = data
            case .failure(let error):
                print("Italian restoranları alınamadı: \(error)")
            }
        }
    }
    
}
