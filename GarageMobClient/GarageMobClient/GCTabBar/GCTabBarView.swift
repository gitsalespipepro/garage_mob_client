//
//  File.swift
//  GarageMobClient
//
//  Created by Rezo Joglidze on 11.11.25.
//

import SwiftUI

struct GCTabBarView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> GCTabBarController {
        return GCTabBarController()
    }

    func updateUIViewController(_ uiViewController: GCTabBarController, context: Context) {
        // No updates needed
        print("dadsadasda")
    }
}
