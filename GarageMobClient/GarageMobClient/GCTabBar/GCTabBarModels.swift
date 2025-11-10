//
//  GCTabBarModels.swift
//  GarageMobClient
//
//  Created by Rezo Joglidze on 11.11.25.
//

import UIKit

enum TabBarModels {
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
        
        var imageName: String {
            switch self {
            case .main:
                return "house.fill"
            case .appointments:
                return "list.bullet.rectangle"
            case .contact:
                return "message"
            case .profile:
                return "person.crop.circle"
            }
        }
        
        var selectedIcon: UIImage? {
            switch self {
            case .main:
                return UIImage(named: "tab_main_selected")
            case .appointments:
                return UIImage(named: "tab_list_selected")
            case .contact:
                return UIImage(named: "tab_contact_selected")
            case .profile:
                return UIImage(named: "tab_profile_selected")
            }
        }
        
        var deselectedIcon: UIImage? {
            switch self {
            case .main:
                return UIImage(named: "tab_main_deselected")
            case .appointments:
                return UIImage(named: "tab_list_deselected")
            case .contact:
                return UIImage(named: "tab_contact_deselected")
            case .profile:
                return UIImage(named: "tab_profile_deselected")
            }
        }
    }
}
