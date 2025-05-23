//
//  ReservationResponseModel.swift
//  DineReserve
//
//  Created by Nazli Gonca on 30.04.2025.
//

import Foundation

// MARK: - ReservationResponse Model

import Foundation

struct ReservationResponseModel: Decodable {
    let id: Int
    let customerId: Int
    let restaurantId: Int
    let reservationDate: String
    let numberOfPeople: Int
    let isCancelled: Bool
}
