//
//  menuAPI.swift
//  DineReserve
//
//  Created by Nazli Gonca on 17.05.2025.
//
import Foundation
import SwiftUI

// MARK: - menu API
enum menuAPI: Endpoint {
    case fetchRestaurantMenuItems(Int)

    
    var path: String {
        switch self {
        case .fetchRestaurantMenuItems(let resteurantId):
            return "/MenuItem/restaurant/\(resteurantId)/menu-items"

        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchRestaurantMenuItems:
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

