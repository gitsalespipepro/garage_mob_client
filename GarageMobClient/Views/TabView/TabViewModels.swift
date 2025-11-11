//
//  GCTabViewModels.swift
//  GarageMobClient
//
//  Created by Rezo Joglidze on 11.11.25.
//

import SwiftUI

enum TabBarItem: CaseIterable {
    case main
    case appointments
    case contact
    case profile
    
    var selectedIcon: Image {
        switch self {
        case .main: Icons.iconMainSelected.originalImage
        case .appointments: Icons.iconListSelected.originalImage
        case .contact: Icons.iconContactSelected.originalImage
        case .profile: Icons.iconProfileSelected.originalImage
        }
    }
    
    var deselectedIcon: Image {
        switch self {
        case .main: Icons.iconMainDeselected.originalImage
        case .appointments: Icons.iconListDeselected.originalImage
        case .contact: Icons.iconContactDeselected.originalImage
        case .profile: Icons.iconProfileDeselected.originalImage
        }
    }
}
