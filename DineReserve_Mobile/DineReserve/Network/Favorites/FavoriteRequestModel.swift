//
//  FavoriteRequestModel.swift
//  DineReserve
//
//  Created by Nazli Gonca on 7.05.2025.
//
import Foundation

struct FavoriteRequestModel: Codable {
    let id: Int
    let name: String
    let description: String
    let street: String
    let city: String
    let zipCode: String
    let phoneNumber: String
    let restaurantCategory: Int
    let capacity: Int
    let photoUrl: String? // null olabileceği için opsiyonel
    let ownerFullName: String
}
