//
//  CoreService+Header.swift
//  GarageBackend
//
//  Created by Rezo Joglidze on 11.11.25.
//

import Foundation

public typealias HeaderParameters = [String: String]

extension CoreServiceImpl {
    func headers(with headers: HeaderParameters = [:]) -> HeaderParameters {
        // For Future Usage
        return headers
    }
}
