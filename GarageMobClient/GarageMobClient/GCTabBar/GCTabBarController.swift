//
//  GCTabBarController.swift
//  GarageMobClient
//
//  Created by Rezo Joglidze on 11.11.25.
//

import SwiftUI

final class GCTabBarController: UITabBarController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTabBarController() {
        viewControllers = TabBarModels.TabBarItem.allCases.map { item in
            let rootController = self.makeHostingController(for: item)
            let navigationController = UINavigationController(rootViewController: rootController)
            let tabBarItem = UITabBarItem(
                title: item.title,
                image: item.deselectedIcon,
                selectedImage: item.selectedIcon
            )
            navigationController.tabBarItem = tabBarItem
            return navigationController
        }
        tabBar.backgroundColor = .white
    }

    private func makeHostingController(for item: TabBarModels.TabBarItem) -> UIViewController {
        let view: AnyView = {
            switch item {
            case .main:
                return AnyView(MainView())
            case .appointments:
                return AnyView(AppointmentsView())
            case .contact:
                return AnyView(ContactView())
            case .profile:
                return AnyView(ProfileView())
            }
        }()

        let hostingController = UIHostingController(rootView: view)
        return hostingController
    }
}

// MARK: - Lifecycle
extension GCTabBarController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarController()
    }
}
