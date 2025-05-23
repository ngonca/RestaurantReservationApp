//
//  String+Extension.swift
//  DineReserve
//
//  Created by Nazli Gonca on 7.05.2025.
//

import Foundation

extension String {
    func toFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        // Eğer ilk format başarısız olursa, fractional seconds olmayan formatı dene
        if let date = dateFormatter.date(from: self) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateFormat = "dd MM yyyy HH:mm:ss"
            return displayFormatter.string(from: date)
        }
        
        // Fractional seconds olmayan format için
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        if let date = dateFormatter.date(from: self) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateFormat = "dd MM yyyy HH:mm:ss"
            return displayFormatter.string(from: date)
        }
        
        return "Invalid Date"
    }
}
