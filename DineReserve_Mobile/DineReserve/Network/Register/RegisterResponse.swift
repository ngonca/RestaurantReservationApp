//
//  RegisterResponse.swift
//  DineReserve
//
//  Created by Nazli Gonca on 6.05.2025.
//

import Foundation

struct RegisterResponse: Codable {
    let id: Int
    let userName: String?
    let email: String
    let isVerified: Bool
    let jwToken: String
    let user: String?
}

