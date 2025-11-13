//
//  OdooProxyRequestModel.swift
//  GarageModels
//
//  Created by Anton Mitrafanau on 13.11.25.
//

import GarageFoundation

public struct OdooProxyRequestModel<Body: Encodable>: PropertyValueTuplable {
    
    let url: String
    let body: Body
}
