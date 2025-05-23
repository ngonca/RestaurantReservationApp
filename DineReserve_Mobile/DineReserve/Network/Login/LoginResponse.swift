//
//  LoginResponse.swift
//  DineReserve
//
//  Created by Nazli Gonca on 21.04.2025.
//

import Foundation

struct LoginResponseModel: Codable {
    let id: Int
    let userName: String
    let email: String
    let isVerified: Bool
    let jwToken: String
    let user: User?

    // Nested user model (şu an null dönüyor ama ileride genişletilebilir)
    struct User: Codable {
        // Buraya User alanlarını ekleyebilirsin, örneğin:
        // let firstName: String
        // let lastName: String
    }
}


