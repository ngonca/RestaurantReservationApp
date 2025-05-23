//
//  FavoritesResponseModel.swift
//  DineReserve
//
//  Created by Nazli Gonca on 21.05.2025.
//


struct FavoritesResponseModel: Codable {
    
    let id: Int
    let name: String
    let description: String
    let street: String
    let city: String
    let zipCode: String
    let phoneNumber: String?
    let restaurantCategory: Int
    let capacity: Int
    let photoUrl: String?
    let ownerFullName: String
}
