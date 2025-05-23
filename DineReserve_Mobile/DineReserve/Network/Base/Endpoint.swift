//
//  Endpoint.swift
//  DineReserve
//
//  Created by Nazli Gonca on 22.03.2025.
//

import Foundation

// MARK: - Endpoint Protocol
protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
}


extension Endpoint {
    
    var baseURL: String { return "https://localhost:9001/api" }
    
    
    var urlRequest: URLRequest? {
        guard let url = URL(string: baseURL + path) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        return request
    }
}
