//
//  MainViewModel.swift
//  GarageMobClient
//
//  Created by Anton Mitrafanau on 13.10.25.
//  Copyright © 2025 ___ORGANIZATIONNAME___ All rights reserved.
//

import Foundation
import Combine

protocol IMainViewModel: AnyObject {
    
    var viewStatePublisher: AnyPublisher<Main.Models.ViewState, Never> { get }
    var viewActionPublisher: AnyPublisher<Main.Models.ViewAction, Never> { get }
    var viewRoutePublisher: AnyPublisher<Main.Models.ViewRoute, Never> { get }

    func process(input: Main.Models.ViewModelInput)
}

final class MainViewModel {
    
    // MARK: Properties
    private let viewStateSubject = CurrentValueSubject<Main.Models.ViewState, Never>(.idle)
    private let viewActionSubject = PassthroughSubject<Main.Models.ViewAction, Never>()
    private let viewRouteSubject = PassthroughSubject<Main.Models.ViewRoute, Never>()
    
    private var subscriptions = Set<AnyCancellable>()
}

// MARK: - IMainViewModel
extension MainViewModel: IMainViewModel {

    var viewStatePublisher: AnyPublisher<Main.Models.ViewState, Never> {
        self.viewStateSubject.eraseToAnyPublisher()
    }
    
    var viewActionPublisher: AnyPublisher<Main.Models.ViewAction, Never> {
        self.viewActionSubject.eraseToAnyPublisher()
    }
    
    var viewRoutePublisher: AnyPublisher<Main.Models.ViewRoute, Never> {
        self.viewRouteSubject.eraseToAnyPublisher()
    }
    
    func process(input: Main.Models.ViewModelInput) {
        input.onLoad
            .sink { [weak self] in
                // handle onLoad here
            }
            .store(in: &self.subscriptions)
    }
}

// MARK: - Private
private extension MainViewModel {

}
