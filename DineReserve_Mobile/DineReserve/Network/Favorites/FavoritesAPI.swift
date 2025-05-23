import Foundation
import SwiftUI

// MARK: - FavoritesAPI
enum FavoritesAPI: Endpoint {
    case fetchFavorites(customerId: Int)
    case deleteFavorite(model: FavoriteRemoveRequestModel)
    case addFavorite(model: FavoriteAddRequestModel) // ✅ Yeni eklenen case

    var path: String {
        switch self {
        case .fetchFavorites(let customerId):
            return "/Favorites/\(customerId)"
        case .deleteFavorite:
            return "/Favorites/remove"
        case .addFavorite:
            return "/Favorites/add" // ✅ Ekleme için endpoint
        }
    }

    var method: HTTPMethod {
        switch self {
        case .fetchFavorites:
            return .get
        case .deleteFavorite:
            return .delete
        case .addFavorite:
            return .post // ✅ POST ile gönderim yapılır
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    var body: Data? {
        switch self {
        case .fetchFavorites:
            return nil
        case .deleteFavorite(let model):
            return try? JSONEncoder().encode(model)
        case .addFavorite(let model):
            return try? JSONEncoder().encode(model)
        }
    }
}

