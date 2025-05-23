//
//  RestaurantAPI.swift
//  DineReserve
//
//  Created by Nazli Gonca on 22.03.2025.
import Foundation
import SwiftUI

// MARK: - Restaurant API
enum RestaurantAPI: Endpoint {
    case fetchRestaurants
    case fetchRestaurant(Int)

    
    var path: String {
        switch self {
        case .fetchRestaurants:
            return "/Restaurants"
        case .fetchRestaurant(let id):
            return "/Restaurants/\(id)"

        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchRestaurants, .fetchRestaurant:
            return .get
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var body: Data? {
        return nil
    }
}

