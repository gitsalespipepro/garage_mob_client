//
//  GarageMobClientApp.swift
//  GarageMobClient
//
//  Created by Rezo Joglidze on 10.11.25.
//

import SwiftUI

@main
struct GarageMobClientApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        WindowGroup {
            GCTabBarView()
        }
    }
}

