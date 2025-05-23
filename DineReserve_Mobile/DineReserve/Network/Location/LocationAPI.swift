import Foundation
import SwiftUI

// MARK: - Location API
enum LocationAPI: Endpoint {
    case fetchRestaurantsByCity(String)

    var path: String {
        switch self {
        case .fetchRestaurantsByCity(let city):
            return "/Restaurants/filter?city=\(city)" // Keep the path as `/api/Restaurants/filter`
        }
    }

    var method: HTTPMethod {
        switch self {
        case .fetchRestaurantsByCity:
            return .get
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    var body: Data? {
        return nil // GET requests typically don’t have a body
    }

    var queryParameters: [String: String]? {
        switch self {
        case .fetchRestaurantsByCity(let city):
            return ["city": city] // Adding query parameter `city=izmir`
        }
    }
}
