//
//  ContactViewModel.swift
//  GarageMobClient
//
//  Created by Anton Mitrafanau on 13.10.25.
//  Copyright © 2025 ___ORGANIZATIONNAME___ All rights reserved.
//

import Foundation
import Combine

protocol IContactViewModel: AnyObject {
    
    var viewStatePublisher: AnyPublisher<Contact.Models.ViewState, Never> { get }
    var viewActionPublisher: AnyPublisher<Contact.Models.ViewAction, Never> { get }
    var viewRoutePublisher: AnyPublisher<Contact.Models.ViewRoute, Never> { get }

    func process(input: Contact.Models.ViewModelInput)
}

final class ContactViewModel {
    
    // MARK: Properties
    private let viewStateSubject = CurrentValueSubject<Contact.Models.ViewState, Never>(.idle)
    private let viewActionSubject = PassthroughSubject<Contact.Models.ViewAction, Never>()
    private let viewRouteSubject = PassthroughSubject<Contact.Models.ViewRoute, Never>()
    
    private var subscriptions = Set<AnyCancellable>()
}

// MARK: - IContactViewModel
extension ContactViewModel: IContactViewModel {

    var viewStatePublisher: AnyPublisher<Contact.Models.ViewState, Never> {
        self.viewStateSubject.eraseToAnyPublisher()
    }
    
    var viewActionPublisher: AnyPublisher<Contact.Models.ViewAction, Never> {
        self.viewActionSubject.eraseToAnyPublisher()
    }
    
    var viewRoutePublisher: AnyPublisher<Contact.Models.ViewRoute, Never> {
        self.viewRouteSubject.eraseToAnyPublisher()
    }
    
    func process(input: Contact.Models.ViewModelInput) {
        input.onLoad
            .sink { [weak self] in
                // handle onLoad here
            }
            .store(in: &self.subscriptions)
    }
}

// MARK: - Private
private extension ContactViewModel {

}
