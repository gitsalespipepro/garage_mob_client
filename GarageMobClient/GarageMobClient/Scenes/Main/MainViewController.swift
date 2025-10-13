//
//  MainViewController.swift
//  GarageMobClient
//
//  Created by Anton Mitrafanau on 13.10.25.
//  Copyright © 2025 ___ORGANIZATIONNAME___ All rights reserved.
//

import UIKit
import Combine

final class MainViewController: UIViewController {
    
    // MARK: Subviews

    // MARK: Other properties
    private var viewModel: IMainViewModel?
    private var subscriptions = Set<AnyCancellable>()
    private let onLoad = PassthroughSubject<Void, Never>()

    // MARK: Life cycle
    convenience init() {
        self.init(nibName: String(describing: Self.self), bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.onLoad.send()
    }
    
    func setDependencies(viewModel: IMainViewModel?) {
        self.viewModel = viewModel
    }
}

// MARK: - Setup
private extension MainViewController {
    
    func setup() {
        self.setupUI()
        self.setupSubscriptions()
    }
    
    func setupUI() {
        // do initial ui setup here
    }
    
    func setupSubscriptions() {
        self.subscriptions.forEach { $0.cancel() }
        self.subscriptions.removeAll()
        
        let input = Main.Models.ViewModelInput(
            onLoad: self.onLoad.eraseToAnyPublisher()
        )
        self.viewModel?.process(input: input)
        
        self.viewModel?.viewStatePublisher
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.handleState(state)
            }
            .store(in: &self.subscriptions)

        self.viewModel?.viewRoutePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] route in
                self?.handleRoute(route)
            }
            .store(in: &self.subscriptions)

        self.viewModel?.viewActionPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] action in
                self?.handleAction(action)
            }
            .store(in: &self.subscriptions)
    }
    
    func handleState(_ state: Main.Models.ViewState) {
        switch state {
        case .idle:
            break
        }
    }

    func handleAction(_ action: Main.Models.ViewAction) {
        switch action {
        }
    }
    
    func handleRoute(_ route: Main.Models.ViewRoute) {
        switch route {
        }
    }
}

// MARK: - Private
private extension MainViewController {

}
