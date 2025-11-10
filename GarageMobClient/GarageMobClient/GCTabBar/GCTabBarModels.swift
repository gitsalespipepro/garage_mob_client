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
        
        var selectedIcon: UIImage? {
            let image = switch self {
            case .main:
                UIImage(named: "tab_main_selected")
            case .appointments:
                UIImage(named: "tab_list_selected")
            case .contact:
                UIImage(named: "tab_contact_selected")
            case .profile:
                UIImage(named: "tab_profile_selected")
            }
            
            return image?.withRenderingMode(.alwaysOriginal)
        }
        
        var deselectedIcon: UIImage? {
            let image = switch self {
            case .main:
                UIImage(named: "tab_main_deselected")
            case .appointments:
                UIImage(named: "tab_list_deselected")
            case .contact:
                UIImage(named: "tab_contact_deselected")
            case .profile:
                UIImage(named: "tab_profile_deselected")
            }
            
            return image?.withRenderingMode(.alwaysOriginal)
        }
    }
}
