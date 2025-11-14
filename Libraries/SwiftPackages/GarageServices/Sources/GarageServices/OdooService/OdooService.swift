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

// MARK: - Usage Example
fileprivate struct OdooProxyExampleRequest: Encodable {
    let param1: Int
    let param2: Bool
}

fileprivate struct OdooProxyExampleResponse: Decodable {
    let field1: String
    let field2: String
}

fileprivate func exampleUsage() {
    let service = OdooServiceImpl(coreService: CoreServiceImpl())
    Task {
        do {
            let requestModel = OdooProxyRequestModel(
                url: "/some/odoo/endpoint",
                body: OdooProxyExampleRequest(param1: 123, param2: true)
            )
            let response: OdooProxyExampleResponse = try await service.odooProxy(model: requestModel)
            print("✅ Got response:", response)
        } catch {
            print("❌ Error:", error)
        }
    }
}
