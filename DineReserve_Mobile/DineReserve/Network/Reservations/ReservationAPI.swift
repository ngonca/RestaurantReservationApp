//
//  ReservationAPI.swift
//  DineReserve
//
//  Created by Nazli Gonca on 30.04.2025.
//

import Foundation
import SwiftUI


// MARK: - Reservation API
enum ReservationAPI: Endpoint {
    case fetchReservations(id: Int?)
    case sendReservation(model: ReservationRequestModel)
    case reservationHistory(customerId: Int)
    case cancelReservation(Int)
    
    var path: String {
        switch self {
        case .fetchReservations(let id):
            // Eğer id varsa, path'i dinamik olarak oluştur
            if let id = id {
                return "/Reservation/\(id)"
            } else {
                return "/Reservation" // Tüm rezervasyonları almak için
            }
        case .sendReservation:
            return "/Reservation"
        case .reservationHistory(let customerId):
            return "/Reservation/past/\(customerId)"
        case .cancelReservation(let id):
            return "/Reservation/\(id)" // <- genellikle rezervasyon endpoint'i olur
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchReservations, .reservationHistory:
            return .get
        case .sendReservation:
                return .post
        case .cancelReservation:
            return .delete
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var body: Data? {
    switch self {
        case .fetchReservations, .reservationHistory:
            return nil
        case .sendReservation(let model):
            do {
                return try JSONEncoder().encode(model) // Profil güncelleme için body'yi oluşturuyoruz
            }catch {
                print("Error encoding register customer: \(error)")
                return nil
            }
            default:
            return nil
        } 
    }
}
