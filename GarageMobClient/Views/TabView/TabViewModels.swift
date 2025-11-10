//
//  GCTabViewModels.swift
//  GarageMobClient
//
//  Created by Rezo Joglidze on 11.11.25.
//

import SwiftUI

enum TabViewModels {
    enum TabBarItem: CaseIterable {
        case main
        case appointments
        case contact
        case profile
        
        var title: String {
            switch self {
            case .main:
                return "Main"
            case .appointments:
                return "Appointments"
            case .contact:
                return "Contact"
            case .profile:
                return "Profile"
            }
        }
        
        var selectedIcon: Image {
            let image = switch self {
            case .main:
                Image("tab_main_selected")
            case .appointments:
                Image("tab_list_selected")
            case .contact:
                Image("tab_contact_selected")
            case .profile:
                Image("tab_profile_selected")
            }
            
            return image.renderingMode(.original)
        }
        
        var deselectedIcon: Image {
            let image = switch self {
            case .main:
                Image("tab_main_deselected")
            case .appointments:
                Image("tab_list_deselected")
            case .contact:
                Image("tab_contact_deselected")
            case .profile:
                Image("tab_profile_deselected")
            }
            
            return image.renderingMode(.original)
        }
    }
}
