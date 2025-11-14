//
//  AuthService.swift
//  GarageServices
//
//  Created by Anton Mitrafanau on 12.11.25.
//

import GarageModels
import GarageBackend

public struct AuthServiceURLs {
    static let googleAuth = "https://garage-mob.spp.dev/api/auth/google/callback"
    static let appleAuth = "https://garage-mob.spp.dev/api/auth/apple/callback"
    static let refreshTokens = "https://garage-mob.spp.dev/api/auth/refresh"
}

public protocol AuthService {
    func googleAuth(model: GoogleAuthRequestModel) async throws -> AuthResponseModel
    func appleAuth(model: AppleAuthRequestModel) async throws -> AuthResponseModel
    func refreshTokens(model: RefreshTokensRequestModel) async throws -> TokensResponseModel
}

public final class AuthServiceImpl {
    
    let coreService: CoreService
    
    public init(coreService: CoreService) {
        self.coreService = coreService
    }
}

extension AuthServiceImpl: AuthService {
    
    public func googleAuth(model: GoogleAuthRequestModel) async throws -> AuthResponseModel {
        let url = AuthServiceURLs.googleAuth
        
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
    
    public func appleAuth(model: AppleAuthRequestModel) async throws -> AuthResponseModel {
        let url = AuthServiceURLs.appleAuth
        
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
    
    public func refreshTokens(model: RefreshTokensRequestModel) async throws -> TokensResponseModel {
        let url = AuthServiceURLs.refreshTokens
        
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
