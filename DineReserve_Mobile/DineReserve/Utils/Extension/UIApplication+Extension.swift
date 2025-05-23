//
//  UIApplication+Extension.swift
//  DineReserve
//
//  Created by Nazli Gonca on 21.05.2025.
//

import UIKit

extension UIApplication {
    func popToRoot() {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let root = scene.windows.first?.rootViewController else { return }

        if let nav = root as? UINavigationController {
            nav.popToRootViewController(animated: true)
        } else {
            root.dismiss(animated: true)
        }
    }
}
