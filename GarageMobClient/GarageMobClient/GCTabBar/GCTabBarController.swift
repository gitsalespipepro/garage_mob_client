//
//  GCTabBarController.swift
//  GarageMobClient
//
//  Created by Rezo Joglidze on 11.11.25.
//

import SwiftUI

final class GCTabBarController: UITabBarController {
//    var coordinators: [Coordinator] = []
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTabBarController() {
        viewControllers = TabBarModels.TabBarItem.allCases.map { item in
            let navigationController = UINavigationController()
            let tabBarItem = UITabBarItem(title: item.title, image: item.deselectedIcon, selectedImage: item.selectedIcon)

            navigationController.tabBarItem = tabBarItem

            setupCoordinator(for: item, with: navigationController)

            return navigationController
        }
        tabBar.tintColor = .clear
    }

    private func setupCoordinator(for item: TabBarModels.TabBarItem, with navigationController: UINavigationController) {
//        let coordinator = switch item {
//        case .home: DashboardCoordinator(navigationController: navigationController, legacyRouter: legacyRouters.transfersRouter)
//        case .offers: OffersCoordinator(navigationController: navigationController)
//        case .menu: MenuCoordinator(navigationController: navigationController)
//        }
//        coordinators.append(coordinator)
//        coordinator.start()
    }
}

// MARK: - Lifecycle
extension GCTabBarController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarController()
    }
}
