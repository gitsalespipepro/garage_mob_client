//
//  OdooService.swift
//  GarageServices
//
//  Created by Anton Mitrafanau on 13.11.25.
//

import GarageModels
import GarageBackend

public struct OdooServiceURLs {
    static let odooProxy = "https://garage-mob.spp.dev/api/odoo/proxy"
}

public protocol OdooService {
    func odooProxy<Request: Encodable, Response: Decodable>(
        model: OdooProxyRequestModel<Request>
    ) async throws -> Response
}

public final class OdooServiceImpl {
    
    let coreService: CoreService
    
    public init(coreService: CoreService) {
        self.coreService = coreService
    }
}

extension OdooServiceImpl: OdooService {
    
    public func odooProxy<Request: Encodable, Response: Decodable>(
        model: OdooProxyRequestModel<Request>
    ) async throws -> Response {
        let url = OdooServiceURLs.odooProxy
        
        let query = (try? model.propertyValueEncodedTuples())?
            .map { QueryParameter(name: $0.property, value: $0.value) }
        
        return try await coreService.request(
            url: url,
            method: .post,
            headers: nil,
            query: query,
            body: nil,
            encoding: .json
        ).responseDecodable()
    }
}
