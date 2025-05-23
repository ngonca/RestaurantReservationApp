//
//  menuResponseModel.swift
//  DineReserve
//
//  Created by Nazli Gonca on 17.05.2025.
//

struct MenuResponseModel: Identifiable, Decodable {
    let id: Int
    let restaurantId: Int
    let name: String
    let description: String
    let photoUrl: String?
    let price: Double
}
