//
//  AuthAssembly.swift
//  GarageMobClient
//
//  Created by Anton Mitrafanau on 22.10.25.
//  Copyright © 2025 ___ORGANIZATIONNAME___ All rights reserved.
//

import UIKit

extension Auth {
    
    enum Assembly {}
}

extension Auth.Assembly {
    
    static func createModule() -> UIViewController {
        let viewModel = AuthViewModel()
        let viewController = AuthViewController()
        viewController.setDependencies(viewModel: viewModel)
        return viewController
    }
}
