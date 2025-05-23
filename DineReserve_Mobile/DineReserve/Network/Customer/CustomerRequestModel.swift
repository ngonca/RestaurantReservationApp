//
//  CustomerRequestModel.swift
//  DineReserve
//
//  Created by Nazli Gonca on 13.05.2025.
//

// MARK: - Example Usage
struct CustomerRequestModel: Codable {
    let id: Int
    let firstName: String?
    let lastName: String?
    let city: String?
    let email: String?
    let phoneNumber: String?
    let profilePictureUrl: String?
}


