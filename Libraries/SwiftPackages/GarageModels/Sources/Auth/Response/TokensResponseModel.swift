//
//  TokensResponseModel.swift
//  GarageModels
//
//  Created by Anton Mitrafanau on 12.11.25.
//

public struct TokensResponseModel: Decodable {
    
    public let accessToken: String
    public let refreshToken: String
}
