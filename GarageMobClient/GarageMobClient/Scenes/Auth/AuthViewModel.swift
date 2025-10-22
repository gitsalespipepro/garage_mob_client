//
//  AuthViewModel.swift
//  GarageMobClient
//
//  Created by Anton Mitrafanau on 22.10.25.
//  Copyright © 2025 ___ORGANIZATIONNAME___ All rights reserved.
//

import Foundation
import Combine

protocol IAuthViewModel: AnyObject {
    
    var viewStatePublisher: AnyPublisher<Auth.Models.ViewState, Never> { get }
    var viewActionPublisher: AnyPublisher<Auth.Models.ViewAction, Never> { get }
    var viewRoutePublisher: AnyPublisher<Auth.Models.ViewRoute, Never> { get }

    func process(input: Auth.Models.ViewModelInput)
}

final class AuthViewModel {
    
    // MARK: Properties
    private let viewStateSubject = CurrentValueSubject<Auth.Models.ViewState, Never>(.idle)
    private let viewActionSubject = PassthroughSubject<Auth.Models.ViewAction, Never>()
    private let viewRouteSubject = PassthroughSubject<Auth.Models.ViewRoute, Never>()
    
    private var subscriptions = Set<AnyCancellable>()
}

// MARK: - IAuthViewModel
extension AuthViewModel: IAuthViewModel {

    var viewStatePublisher: AnyPublisher<Auth.Models.ViewState, Never> {
        self.viewStateSubject.eraseToAnyPublisher()
    }
    
    var viewActionPublisher: AnyPublisher<Auth.Models.ViewAction, Never> {
        self.viewActionSubject.eraseToAnyPublisher()
    }
    
    var viewRoutePublisher: AnyPublisher<Auth.Models.ViewRoute, Never> {
        self.viewRouteSubject.eraseToAnyPublisher()
    }
    
    func process(input: Auth.Models.ViewModelInput) {
        input.onLoad
            .sink { [weak self] in
                // handle onLoad here
            }
            .store(in: &self.subscriptions)
    }
}

// MARK: - Private
private extension AuthViewModel {

}
