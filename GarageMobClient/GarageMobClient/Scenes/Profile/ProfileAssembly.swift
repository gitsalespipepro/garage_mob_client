//
//  ProfileAssembly.swift
//  GarageMobClient
//
//  Created by Anton Mitrafanau on 13.10.25.
//  Copyright © 2025 ___ORGANIZATIONNAME___ All rights reserved.
//

import UIKit

extension Profile {
    
    enum Assembly {}
}

extension Profile.Assembly {
    
    static func createModule() -> UIViewController {
        let viewModel = ProfileViewModel()
        let viewController = ProfileViewController()
        viewController.setDependencies(viewModel: viewModel)
        return viewController
    }
}
