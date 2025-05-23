//
//  CustomerAPI.swift
//  DineReserve
//
//  Created by Nazli Gonca on 30.04.2025.
//

import Foundation
import SwiftUI

// MARK: - Example API Target
enum CustomerAPI: Endpoint {
    case fetchCustomers
    case updateCustomerProfile(id: Int, profile: CustomerRequestModel)
    
    var path: String {
        switch self {
        case .fetchCustomers: return "/Customer"
        case .updateCustomerProfile(let id,_): return "/Customer/\(id)" // Güncelleme endpoint'i
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchCustomers:
            return .get  // Veriyi almak için GET metodu
        case .updateCustomerProfile:
            return .put // Profil güncelleme için POST metodu
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var body: Data? {
        switch self {
        case .fetchCustomers:
            return nil // GET isteği için body gereksiz
        case .updateCustomerProfile(_,let profile):
            do {
                return try JSONEncoder().encode(profile) // Profil güncelleme için body'yi oluşturuyoruz
            } catch {
                //print("Error encoding profile: \(error)")
                return nil
            }
        }
    }
}

