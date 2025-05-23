//
//  ResevationRequestModel.swift
//  DineReserve
//
//  Created by Nazli Gonca on 7.05.2025.
//

struct ReservationRequestModel: Codable {
    let customerId: Int?
    let restaurantId: Int
    let reservationDate: String
    let timeSlot: String
    let numberOfPeople: Int
    let availabilityId: Int
}

