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
            return Asset.Images.tabMainIdle.image
        case .appointmentList:
            return Asset.Images.tabListIdle.image
        case .contact:
            return Asset.Images.tabContactIdle.image
        case .profile:
            return Asset.Images.tabProfileIdle.image
        }
    }
    
    var selectedImage: UIImage? {
        switch self {
        case .main:
            return Asset.Images.tabMainSelected.image
        case .appointmentList:
            return Asset.Images.tabListSelected.image
        case .contact:
            return Asset.Images.tabContactSelected.image
        case .profile:
            return Asset.Images.tabProfileSelected.image
        }
    }
}
