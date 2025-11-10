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
        button.addTarget(
            self,
            action: #selector(onAppleAuthButtonTap),
            for: .touchUpInside
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
    
    @objc
    func onAppleAuthButtonTap() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email] // Request full name and email
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
//        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

// MARK: - ASAuthorizationControllerDelegate
extension AuthViewController: ASAuthorizationControllerDelegate {
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        print("Authorization successful")
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // **This is where you handle the ASAuthorizationAppleIDCredential**
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            let identityToken = appleIDCredential.identityToken
            let authorizationCode = appleIDCredential.authorizationCode
            
            // Use the credential information to sign the user in to your app/backend service
            // Note: Full name and email are only provided on the *first* sign-in.
            // You should save this information securely (e.g., to your server or the keychain) for future use.
            print("User ID: \(userIdentifier)")
            print("Email: \(email ?? "")")
        }
    }
    
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        // Handle error here (e.g., user dismissed the login prompt)
        print("Sign in with Apple failed: \(error.localizedDescription)")
    }
}
