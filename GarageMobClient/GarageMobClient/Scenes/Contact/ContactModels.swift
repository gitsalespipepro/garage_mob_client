//
//  ContactModels.swift
//  GarageMobClient
//
//  Created by Anton Mitrafanau on 13.10.25.
//  Copyright © 2025 ___ORGANIZATIONNAME___ All rights reserved.
//

import Foundation
import Combine

enum Contact {}

extension Contact {
    
    enum Models {}
}

extension Contact.Models {

    // MARK: Input
    struct ViewModelInput {
        let onLoad: AnyPublisher<Void, Never>
    }

    // MARK: Output
    enum ViewState: Equatable {
        case idle
    }

    enum ViewAction {
    }

    enum ViewRoute {
    }
}

