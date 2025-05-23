//
//  RestaurantResponseModel.swift
//  DineReserve
//
//  Created by Nazli Gonca on 22.03.2025.
//


// MARK: - Restaurant Response Model
struct RestaurantResponseModel: Decodable {
    let id: Int?
    let name: String?
    let description: String?
    let street: String?
    let city: String?
    let zipCode: String?
    let phoneNumber: String?
    let restaurantCategory: Int? // restaurantCategory Int? olarak tanımlı, bu doğru
    let capacity: Int? // capacity de sayısal bir değer olduğundan Int? olmalı
    let ownerFullName: String?
    let photoUrl: String? // photoUrl burada opsiyonel olmalı, çünkü null gelebilir
}

