//
//  OdooProxyRequestModel.swift
//  GarageModels
//
//  Created by Anton Mitrafanau on 13.11.25.
//

import GarageFoundation

public struct OdooProxyRequestModel<Body: Encodable>: PropertyValueTuplable {
    
    public let url: String
    public let body: Body
    
    public init(url: String, body: Body) {
        self.url = url
        self.body = body
    }
}
