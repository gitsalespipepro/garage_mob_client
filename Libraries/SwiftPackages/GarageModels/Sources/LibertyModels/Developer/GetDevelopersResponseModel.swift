//
//  File.swift
//  GarageModels
//
//  Created by Rezo Joglidze on 11.11.25.
//

import Foundation

public typealias GetDevelopersModel = GetDevelopersResponseModel

public struct GetDevelopersResponseModel: Decodable, Identifiable, Hashable {
    public var id: UUID = .init()
    public  let name: String
    public let surname: String
    public let yearsOfExperience: Int
    public let currentLocation: String
    public let company: String
    public let about: String
}
