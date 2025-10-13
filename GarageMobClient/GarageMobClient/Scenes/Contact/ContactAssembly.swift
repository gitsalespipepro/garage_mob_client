//
//  ContactAssembly.swift
//  GarageMobClient
//
//  Created by Anton Mitrafanau on 13.10.25.
//  Copyright © 2025 ___ORGANIZATIONNAME___ All rights reserved.
//

import UIKit

extension Contact {
    
    enum Assembly {}
}

extension Contact.Assembly {
    
    static func createModule() -> UIViewController {
        let viewModel = ContactViewModel()
        let viewController = ContactViewController()
        viewController.setDependencies(viewModel: viewModel)
        return viewController
    }
}
