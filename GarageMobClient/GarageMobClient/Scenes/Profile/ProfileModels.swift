//
//  ProfileModels.swift
//  GarageMobClient
//
//  Created by Anton Mitrafanau on 13.10.25.
//  Copyright © 2025 ___ORGANIZATIONNAME___ All rights reserved.
//

import Foundation
import Combine

enum Profile {}

extension Profile {
    
    enum Models {}
}

extension Profile.Models {

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

