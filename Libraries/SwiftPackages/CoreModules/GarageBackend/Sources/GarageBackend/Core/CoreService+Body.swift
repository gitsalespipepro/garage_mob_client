//
//  CoreService+Body.swift
//  GarageBackend
//
//  Created by Rezo Joglidze on 11.11.25.
//

import Foundation

public typealias BodyParameters = [String: Any]

extension CoreServiceImpl {
    func encodableToDictionary(_ encodable: Encodable?) -> BodyParameters? {
        guard let encodable = encodable else { return nil }

        do {
            let jsonData = try JSONEncoder().encode(encodable)
            guard let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else { return nil }
            return dictionary
        } catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
    }
}
