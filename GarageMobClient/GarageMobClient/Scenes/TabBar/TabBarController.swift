//
//  TabBarController.swift
//  GarageMobClient
//
//  Created by Anton Mitrafanau on 13.10.25.
//

import UIKit
import Combine
import SnapKit

final class TabBarViewController: UITabBarController {
    
    // MARK: Subviews
    private lazy var customTabBar: TabBar = {
        let tabBar = TabBar()
        tabBar.selectedTabPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] tab in
                self?.handleTabChange(tab)
            }
            .store(in: &self.subscriptions)
        return tabBar
    }()
    
    // MARK: Other properties
    private var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
}

// MARK: - Setup
private extension TabBarViewController {
    
    func setup() {
        self.setupViewControllers()
        self.setupTabBar()
        self.setupSubscriptions()
    }
    
    func setupViewControllers() {
        let mainFlow = self.mainFlow()
        let appointmentListFlow = self.appointmentListFlow()
        let contactFlow = self.contactFlow()
        let profileFlow = self.profileFlow()
        
        self.viewControllers = [
            mainFlow,
            appointmentListFlow,
            contactFlow,
            profileFlow
        ]
    }
    
    func setupTabBar() {
        self.tabBar.isHidden = true
        self.view.addSubview(self.customTabBar)
        self.customTabBar.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(TabBar.Constants.height)
        }
        
        // add bottom line view to fill the space under tab bar
        let bottomLineView = UIView()
        bottomLineView.backgroundColor = .gray
        self.view.addSubview(bottomLineView)
        bottomLineView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(self.customTabBar.snp.bottom)
        }
    }
    
    func setupSubscriptions() {

    }
}

// MARK: - Setup viewControllers
private extension TabBarViewController {
    
    func mainFlow() -> UIViewController {
        let controller = Main.Assembly.createModule()
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.isNavigationBarHidden = true
        navigationController.delegate = self
        return navigationController
    }
    
    func appointmentListFlow() -> UIViewController {
        let controller = AppointmentList.Assembly.createModule()
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.isNavigationBarHidden = true
        return navigationController
    }
    
    func contactFlow() -> UIViewController {
        let controller = Contact.Assembly.createModule()
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.isNavigationBarHidden = true
        return navigationController
    }
    
    func profileFlow() -> UIViewController {
        let controller = Profile.Assembly.createModule()
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.isNavigationBarHidden = true
        return navigationController
    }
}

// MARK: - Logic
private extension TabBarViewController {
    
    func handleTabChange(_ tab: Tab) {
        self.selectedIndex = tab.index
    }
}

// MARK: - Navigation
private extension TabBarViewController {
    
}

// MARK: - UINavigationControllerDelegate
extension TabBarViewController: UINavigationControllerDelegate {
    
    func navigationController(
        _ navigationController: UINavigationController,
        willShow viewController: UIViewController,
        animated: Bool
    ) {
        self.tabBar.isHidden = true
        if viewController.hidesBottomBarWhenPushed {
            self.customTabBar.isHidden = true
        } else {
            self.customTabBar.isHidden = false
        }
    }
}
