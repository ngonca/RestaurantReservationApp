//
//  CustomerResponseModel.swift
//  DineReserve
//
//  Created by Nazli Gonca on 30.04.2025.
//

struct CustomerResponseModel: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let city: String
    let email: String
    let phoneNumber: String
    let profilePictureUrl: String?
}
