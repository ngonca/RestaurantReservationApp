//
//  ItalianRestaurantsView.swift
//  DineReserve
//
//  Created by Nazli Gonca on 14.05.2025.
//

import SwiftUI

struct ItalianRestaurantsView: View {
    @State private var italianRestaurants: [RestaurantResponseModel] = []

    var body: some View {
        VStack {
            // Restoranlar Listesi
            List(italianRestaurants, id: \.id) { restaurant in
                RestaurantCard(restaurant: restaurant)
            }
            .onAppear {
                fetchItalianRestaurants()
            }

            Spacer()
        }
        .navigationTitle("Italian Restaurants")
    }

    // Italian restoranlarını çeker
    func fetchItalianRestaurants() {
        // Burada, Italian restoranlarını çekecek bir API çağrısı yapılır. Şu an örnek olarak sabit veriler kullanıldı.
        NetworkManager.shared.request(endpoint: CategoryAPI.fetchRestaurantsByCategory(0)) { (result: Result<[RestaurantResponseModel], APIError>) in
            switch result {
            case .success(let data):
                italianRestaurants = data
            case .failure(let error):
                print("Italian restoranları alınamadı: \(error)")
            }
        }
    }
    
}
