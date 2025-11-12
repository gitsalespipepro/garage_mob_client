//
//  ClientModel.swift
//  GarageModels
//
//  Created by Anton Mitrafanau on 12.11.25.
//

public struct ClientModel: Decodable {
    
    public let id: Int
    public let email: String
    public let name: String
    public let lastName: String
    public let phoneNumber: String?
    public let mobileNumber: String?
    public let address: AddressModel?
    
    enum CodingKeys: String, CodingKey {
        case id, email, name, address
        case lastName = "last_name"
        case phoneNumber = "phone_number"
        case mobileNumber = "mobile_number"
    }
}
