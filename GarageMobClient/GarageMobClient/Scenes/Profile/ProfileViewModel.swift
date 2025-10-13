//
//  ProfileViewModel.swift
//  GarageMobClient
//
//  Created by Anton Mitrafanau on 13.10.25.
//  Copyright © 2025 ___ORGANIZATIONNAME___ All rights reserved.
//

import Foundation
import Combine

protocol IProfileViewModel: AnyObject {
    
    var viewStatePublisher: AnyPublisher<Profile.Models.ViewState, Never> { get }
    var viewActionPublisher: AnyPublisher<Profile.Models.ViewAction, Never> { get }
    var viewRoutePublisher: AnyPublisher<Profile.Models.ViewRoute, Never> { get }

    func process(input: Profile.Models.ViewModelInput)
}

final class ProfileViewModel {
    
    // MARK: Properties
    private let viewStateSubject = CurrentValueSubject<Profile.Models.ViewState, Never>(.idle)
    private let viewActionSubject = PassthroughSubject<Profile.Models.ViewAction, Never>()
    private let viewRouteSubject = PassthroughSubject<Profile.Models.ViewRoute, Never>()
    
    private var subscriptions = Set<AnyCancellable>()
}

// MARK: - IProfileViewModel
extension ProfileViewModel: IProfileViewModel {

    var viewStatePublisher: AnyPublisher<Profile.Models.ViewState, Never> {
        self.viewStateSubject.eraseToAnyPublisher()
    }
    
    var viewActionPublisher: AnyPublisher<Profile.Models.ViewAction, Never> {
        self.viewActionSubject.eraseToAnyPublisher()
    }
    
    var viewRoutePublisher: AnyPublisher<Profile.Models.ViewRoute, Never> {
        self.viewRouteSubject.eraseToAnyPublisher()
    }
    
    func process(input: Profile.Models.ViewModelInput) {
        input.onLoad
            .sink { [weak self] in
                // handle onLoad here
            }
            .store(in: &self.subscriptions)
    }
}

// MARK: - Private
private extension ProfileViewModel {

}
