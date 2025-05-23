//
//  DineReserveApp.swift
//  DineReserve
//
//  Created by Nazli Gonca on 25.02.2025.
//

import SwiftUI

@main
struct DineReserveApp: App {
    
    @StateObject private var session = UserSession()
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(session)
        }
    }
}


