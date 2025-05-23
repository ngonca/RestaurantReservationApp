//
//  UserSession.swift
//  DineReserve
//
//  Created by Nazli Gonca on 15.05.2025.
//

import Foundation
import Combine

class UserSession: ObservableObject {
    @Published var userId: Int?
    @Published var userName: String = ""
    @Published var email: String = ""
    @Published var jwToken: String = ""
    @Published var isVerified: Bool = false

    func update(from loginResponse: LoginResponseModel) {
        self.userId = loginResponse.id
        self.userName = loginResponse.userName
        self.email = loginResponse.email
        self.jwToken = loginResponse.jwToken
        self.isVerified = loginResponse.isVerified
    }

    func clear() {
        self.userId = nil
        self.userName = ""
        self.email = ""
        self.jwToken = ""
        self.isVerified = false
    }
}

