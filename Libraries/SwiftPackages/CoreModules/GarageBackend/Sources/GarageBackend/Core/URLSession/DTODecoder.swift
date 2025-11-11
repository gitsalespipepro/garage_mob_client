//
//  DTODecoder.swift
//  GarageBackend
//
//  Created by Rezo Joglidze on 11.11.25.
//

import Foundation

public struct DTODecoder {

   public static func decode<T>(type: T.Type, data: Data) -> T? where T : Decodable {
        if type == Data.self, let data = data as? T {
            return data
        }
        
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            return result
        } catch {
            print("🔴 Parse Error", error)
            return nil
        }
    }
}
