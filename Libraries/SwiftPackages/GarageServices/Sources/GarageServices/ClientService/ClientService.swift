//
//  ClientService.swift
//  GarageServices
//
//  Created by Anton Mitrafanau on 13.11.25.
//

import GarageModels
import GarageBackend

public struct ClientServiceURLs {
    static func updateClient(id: Int) -> String {
        "https://garage-mob.spp.dev/api/clients/\(id)"
    }
    static func getClientById(id: Int) -> String {
        "https://garage-mob.spp.dev/api/clients/\(id)"
    }
}

public protocol ClientService {
    func updateClient(
        id: Int,
        model: UpdateClientRequestModel
    ) async throws -> ClientModel
    func getClientById(id: Int) async throws -> ClientModel
}

public final class ClientServiceImpl {
    
    let coreService: CoreService
    
    public init(coreService: CoreService) {
        self.coreService = coreService
    }
}

extension ClientServiceImpl: ClientService {
    
    public func updateClient(
        id: Int,
        model: UpdateClientRequestModel
    ) async throws -> ClientModel {
        let url = ClientServiceURLs.updateClient(id: id)
        
        let query = (try? model.propertyValueEncodedTuples())?
            .map { QueryParameter(name: $0.property, value: $0.value) }
        
        return try await coreService.request(
            url: url,
            method: .put,
            headers: nil,
            query: query,
            body: nil,
            encoding: .json
        ).responseDecodable()
    }
    
    public func getClientById(id: Int) async throws -> ClientModel {
        let url = ClientServiceURLs.getClientById(id: id)
        
        return try await coreService.request(
            url: url,
            method: .get,
            headers: nil,
            query: nil,
            body: nil,
            encoding: .json
        ).responseDecodable()
    }
}
