//
//  Tab.swift
//  GarageMobClient
//
//  Created by Anton Mitrafanau on 13.10.25.
//

import UIKit

enum Tab {
    case main
    case appointmentList
    case contact
    case profile
    
    var index: Int {
        switch self {
        case .main:
            return 0
        case .appointmentList:
            return 1
        case .contact:
            return 2
        case .profile:
            return 3
        }
    }
    
    var image: UIImage? {
        switch self {
        case .main:
            return UIImage(named: "tab_main_idle")
        case .appointmentList:
            return UIImage(named: "tab_list_idle")
        case .contact:
            return UIImage(named: "tab_contact_idle")
        case .profile:
            return UIImage(named: "tab_profile_idle")
        }
    }
    
    var selectedImage: UIImage? {
        switch self {
        case .main:
            return UIImage(named: "tab_main_selected")
        case .appointmentList:
            return UIImage(named: "tab_list_selected")
        case .contact:
            return UIImage(named: "tab_contact_selected")
        case .profile:
            return UIImage(named: "tab_profile_selected")
        }
    }
}
