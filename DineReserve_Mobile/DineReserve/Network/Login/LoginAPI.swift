//
//  LoginAPI.swift
//  DineReserve
//
//  Created by Nazli Gonca on 5.05.2025.
//

import Foundation
import SwiftUI

// MARK: - LoginAPI  Target
enum LoginAPI: Endpoint {

    case loginCustomer(LoginRequest)
    
    var path: String {
        switch self {
        case .loginCustomer: return "/Account/authenticate"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .loginCustomer:
            return .post
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var body: Data? {
        switch self {
        case .loginCustomer(let profile):
            do {
                return try JSONEncoder().encode(profile) // Profil güncelleme için body'yi oluşturuyoruz
            }catch {
                print("Error encoding login customer: \(error)")
                return nil
            }
        }
    }
}


