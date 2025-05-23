//
//  CategoryAPI.swift
//  DineReserve
//
//  Created by Nazli Gonca on 14.05.2025.
//

import Foundation
import SwiftUI

// MARK: - Category API
enum CategoryAPI: Endpoint {
    case fetchRestaurantsByCategory(Int)

    var path: String {
        switch self {
        case .fetchRestaurantsByCategory(let category):
            return "/Restaurants/by-category?category=\(category)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .fetchRestaurantsByCategory:
            return .get
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    var body: Data? {
        return nil // GET requests typically don’t have a body
    }

    //return ["category": String(category)]
}
