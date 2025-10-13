//
//  AppointmentListAssembly.swift
//  GarageMobClient
//
//  Created by Anton Mitrafanau on 13.10.25.
//  Copyright © 2025 ___ORGANIZATIONNAME___ All rights reserved.
//

import UIKit

extension AppointmentList {
    
    enum Assembly {}
}

extension AppointmentList.Assembly {
    
    static func createModule() -> UIViewController {
        let viewModel = AppointmentListViewModel()
        let viewController = AppointmentListViewController()
        viewController.setDependencies(viewModel: viewModel)
        return viewController
    }
}
