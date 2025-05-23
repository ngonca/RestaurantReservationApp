//
//  PaymentRequest.swift
//  DineReserve
//
//  Created by Nazli Gonca on 8.05.2025.
//

import Foundation

struct PaymentRequestModel: Codable {
    var paymentMethod: Int
    var reservationId: Int
    var cardNumber: String
    var expirationDate: String
    var cardOwner: String
    var paymentDate: String
    var restaurantId: Int
    var cvv: String
}

