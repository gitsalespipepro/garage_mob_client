//
//  TabBarView.swift
//  GarageMobClient
//
//  Created by Rezo Joglidze on 11.11.25.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab: TabBarItem = .main
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            // Tab 1: Main
            tabContent(.main)
                .tag(TabBarItem.main)
                .tabItem {
                    selectedTab == .main ? TabBarItem.main.selectedIcon : TabBarItem.main.deselectedIcon
                }
            
            // Tab 2: Appointments
            tabContent(.appointments)
                .tag(TabBarItem.appointments)
                .tabItem {
                    selectedTab == .appointments ? TabBarItem.appointments.selectedIcon : TabBarItem.appointments.deselectedIcon
                }
            
            // Tab 3: Contact
            tabContent(.contact)
                .tag(TabBarItem.contact)
                .tabItem {
                    selectedTab == .contact ? TabBarItem.contact.selectedIcon : TabBarItem.contact.deselectedIcon
                }
            
            // Tab 4: Profile
            tabContent(.profile)
                .tag(TabBarItem.profile)
                .tabItem {
                    selectedTab == .profile ? TabBarItem.profile.selectedIcon : TabBarItem.profile.deselectedIcon
                }
        }
    }
    
    @ViewBuilder
    private func tabContent(_ item: TabBarItem) -> some View {
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
