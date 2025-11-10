//
//  TabBarView.swift
//  GarageMobClient
//
//  Created by Rezo Joglidze on 11.11.25.
//

import SwiftUI

struct TabBarView: View {
    @SceneStorage("selectedTab") private var selectedTabIndex = 0
    
    var body: some View {
        TabView(selection: $selectedTabIndex) {
            Tab("Main", systemImage: "ruler", value: 0) {
                tabItem(.main)
            }
            
            Tab("appointments", systemImage: "magnifyingglass", value: 1) {
                tabItem(.appointments)
            }
            
            Tab("contact", systemImage: "ruler", value: 2) {
                tabItem(.contact)
            }
            
            Tab("contact", systemImage: "ruler", value: 3) {
                tabItem(.profile)
            }
        }
    }
    
    private func tabItem(_ item: TabViewModels.TabBarItem) -> some View {
        VStack {
            switch item {
            case .main:
                MainView()
            case .appointments:
                AppointmentsView()
            case .contact:
                ContactView()
            case .profile:
                ProfileView()
            }
        }
    }
}
