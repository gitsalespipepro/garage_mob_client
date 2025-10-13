//
//  AppointmentListViewModel.swift
//  GarageMobClient
//
//  Created by Anton Mitrafanau on 13.10.25.
//  Copyright © 2025 ___ORGANIZATIONNAME___ All rights reserved.
//

import Foundation
import Combine

protocol IAppointmentListViewModel: AnyObject {
    
    var viewStatePublisher: AnyPublisher<AppointmentList.Models.ViewState, Never> { get }
    var viewActionPublisher: AnyPublisher<AppointmentList.Models.ViewAction, Never> { get }
    var viewRoutePublisher: AnyPublisher<AppointmentList.Models.ViewRoute, Never> { get }

    func process(input: AppointmentList.Models.ViewModelInput)
}

final class AppointmentListViewModel {
    
    // MARK: Properties
    private let viewStateSubject = CurrentValueSubject<AppointmentList.Models.ViewState, Never>(.idle)
    private let viewActionSubject = PassthroughSubject<AppointmentList.Models.ViewAction, Never>()
    private let viewRouteSubject = PassthroughSubject<AppointmentList.Models.ViewRoute, Never>()
    
    private var subscriptions = Set<AnyCancellable>()
}

// MARK: - IAppointmentListViewModel
extension AppointmentListViewModel: IAppointmentListViewModel {

    var viewStatePublisher: AnyPublisher<AppointmentList.Models.ViewState, Never> {
        self.viewStateSubject.eraseToAnyPublisher()
    }
    
    var viewActionPublisher: AnyPublisher<AppointmentList.Models.ViewAction, Never> {
        self.viewActionSubject.eraseToAnyPublisher()
    }
    
    var viewRoutePublisher: AnyPublisher<AppointmentList.Models.ViewRoute, Never> {
        self.viewRouteSubject.eraseToAnyPublisher()
    }
    
    func process(input: AppointmentList.Models.ViewModelInput) {
        input.onLoad
            .sink { [weak self] in
                // handle onLoad here
            }
            .store(in: &self.subscriptions)
    }
}

// MARK: - Private
private extension AppointmentListViewModel {

}
