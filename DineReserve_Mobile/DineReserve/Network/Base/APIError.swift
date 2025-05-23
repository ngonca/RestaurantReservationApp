//
//  APIError.swift
//  DineReserve
//
//  Created by Nazli Gonca on 22.03.2025.
//

import Foundation

// MARK: - API Error Enum
enum APIError: Error {
    case invalidURL
    case requestFailed
    case decodingError
    case unknown(Error)
}
