//
//  MainViewModel.swift
//  GarageMobClient
//
//  Created by Anton Mitrafanau on 13.10.25.
//  Copyright © 2025 ___ORGANIZATIONNAME___ All rights reserved.
//

import Combine
import GarageModels
import GarageServices
import GarageBackend
import Foundation

@Observable
final class MainViewModel {
    // MARK: Properties
    private(set) var developers: [GetDevelopersModel] = []
    
    private let developerService: DeveloperService
    
    init() {
        self.developerService = DeveloperServiceImpl(coreService: CoreServiceImpl())
    }
}

extension MainViewModel {
    func loadData() {
        Task {
            do {
                let developers: [GetDevelopersModel] = try await developerService.fetchDevelopers()
                guard !Task.isCancelled else { return }
                
                self.developers = developers
            } catch {
                guard !Task.isCancelled else { return }
                
                print(error.localizedDescription)
            }
        }
    }
}
