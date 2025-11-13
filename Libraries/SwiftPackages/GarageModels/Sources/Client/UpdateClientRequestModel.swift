//
//  UpdateClientRequestModel.swift
//  GarageModels
//
//  Created by Anton Mitrafanau on 13.11.25.
//

import GarageFoundation

public struct UpdateClientRequestModel: PropertyValueTuplable {
    
    public let email: String?
    public let name: String?
    public let lastName: String?
    public let phoneNumber: String?
    public let mobileNumber: String?
    public let addressId: Int?
    
    enum CodingKeys: String, CodingKey {
        case email, name
        case lastName = "last_name"
        case phoneNumber = "phone_number"
        case mobileNumber = "mobile_number"
        case addressId = "address_id"
    }
}
