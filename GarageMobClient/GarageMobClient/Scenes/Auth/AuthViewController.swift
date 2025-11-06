//
//  AuthViewController.swift
//  GarageMobClient
//
//  Created by Anton Mitrafanau on 22.10.25.
//  Copyright © 2025 ___ORGANIZATIONNAME___ All rights reserved.
//

import UIKit
import SnapKit
import Combine
import AuthenticationServices

final class AuthViewController: UIViewController {
    
    // MARK: Subviews
    @IBOutlet private weak var appleAuthButtonContainer: UIView!
    private lazy var appleAuthButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton(
            type: .continue,
            style: .black
        )
        return button
    }()

    // MARK: Other properties
    private var viewModel: IAuthViewModel?
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
    
    func setDependencies(viewModel: IAuthViewModel?) {
        self.viewModel = viewModel
    }
}

// MARK: - Setup
private extension AuthViewController {
    
    func setup() {
        self.setupUI()
        self.setupSubscriptions()
    }
    
    func setupUI() {
        appleAuthButtonContainer.addSubview(appleAuthButton)
        appleAuthButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupSubscriptions() {
        self.subscriptions.forEach { $0.cancel() }
        self.subscriptions.removeAll()
        
        let input = Auth.Models.ViewModelInput(
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
    
    func handleState(_ state: Auth.Models.ViewState) {
        switch state {
        case .idle:
            break
        }
    }

    func handleAction(_ action: Auth.Models.ViewAction) {
        switch action {
        }
    }
    
    func handleRoute(_ route: Auth.Models.ViewRoute) {
        switch route {
        }
    }
}

// MARK: - Private
private extension AuthViewController {

}
