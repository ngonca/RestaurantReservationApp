//
//  RegisterRequest.swift
//  DineReserve
//
//  Created by Nazli Gonca on 6.05.2025.
//

import Foundation

struct RegisterRequest: Codable {
    let firstName: String
    let lastName: String
    let city: String
    let email: String
    let phoneNumber: String
    let password: String
    let confirmPassword: String
}
