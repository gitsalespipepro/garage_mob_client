//
//  AddressModel.swift
//  GarageModels
//
//  Created by Anton Mitrafanau on 12.11.25.
//

public struct AddressModel: Decodable {
    
    public let id: Int
    public let street: String
    public let street2: String
    public let city: String
    public let zip: String
    public let latitude: Double
    public let longitude: Double
}
