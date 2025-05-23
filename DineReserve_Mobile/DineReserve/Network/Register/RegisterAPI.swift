//
//  RegisterAPI.swift
//  DineReserve
//
//  Created by Nazli Gonca on 21.05.2025.
//

import Foundation
import SwiftUI

// MARK: - Example API Target
enum RegisterAPI: Endpoint {
    case registerCustomer(RegisterRequest)
    
    var path: String {
        switch self {
        case .registerCustomer: return "/Account/register-customer"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .registerCustomer:
            return .post
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var body: Data? {
        switch self {
        case .registerCustomer(let profile):
            do {
                return try JSONEncoder().encode(profile) // Profil güncelleme için body'yi oluşturuyoruz
            } catch {
                print("Error encoding register customer: \(error)")
                return nil
            }
        }
    }
}

