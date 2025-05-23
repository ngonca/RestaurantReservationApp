//
//  Date+Extension.swift
//  DineReserve
//
//  Created by Nazli Gonca on 7.05.2025.
//

import Foundation

extension Date {
    func toISO8601String() -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.string(from: self)
    }
}
