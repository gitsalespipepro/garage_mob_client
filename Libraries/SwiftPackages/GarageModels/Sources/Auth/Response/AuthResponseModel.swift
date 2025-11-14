//
//  AuthResponseModel.swift
//  GarageModels
//
//  Created by Anton Mitrafanau on 12.11.25.
//

public struct AuthResponseModel: Decodable {
    
    public let client: ClientModel
    public let accessToken: String
    public let refreshToken: String
}
