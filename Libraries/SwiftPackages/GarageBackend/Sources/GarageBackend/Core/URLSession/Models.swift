//
//  Models.swift
//  GarageBackend
//
//  Created by Rezo Joglidze on 11.11.25.
//

import Foundation

public struct MediaFile {
    public var key: String
    public var data: Data
    public var name: String?
    public var type: String?
    
    public init(key: String, data: Data, name: String? = nil, type: String? = nil) {
        self.key = key
        self.data = data
        self.name = name
        self.type = type
    }
}
