//
//  PaymentAPI.swift
//  DineReserve
//
//  Created by Nazli Gonca on 8.05.2025.
//

import Foundation
import SwiftUI

// MARK: - PaymentAPI
enum PaymentAPI: Endpoint {
    case postPayment(model: PaymentRequestModel)

    var path: String {
        switch self {

        case .postPayment:
            return "/Payment"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .postPayment:
            return .post
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    var body: Data? {
        switch self {
        case .postPayment(let model):
            return try? JSONEncoder().encode(model)
        }
    }
}

