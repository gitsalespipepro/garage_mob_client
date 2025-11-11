//
//  CoreService+Response.swift
//  GarageBackend
//
//  Created by Rezo Joglidze on 11.11.25.
//

import Foundation
import Combine

public extension CoreRequest {
    func responseDecodable<T: Decodable>() async throws(CoreServiceError) -> T {
        let data = try await response()
        
        guard let resultDTO = DTODecoder.decode(type: T.self, data: data) else {
            throw CoreServiceError(code: .other(code: "DecodingError"), message: "Could not decode data")
        }
        
        return resultDTO
    }

    func responseOptionalDecodable<T: Decodable>() async throws(CoreServiceError) -> T? {
        let data = try await response()
        return DTODecoder.decode(type: T.self, data: data)
    }
    
    func responseDecodable<T: Decodable>() async throws(CoreServiceError) -> T where T: RangeReplaceableCollection {
        let data = try await response()
        
        guard let resultDTO = DTODecoder.decode(type: T.self, data: data) else {
            throw CoreServiceError(code: .other(code: "DecodingError"), message: "Could not decode data")
        }
        
        return resultDTO
    }

    func responseEmpty() async throws(CoreServiceError) {
        _ = try await response()
    }

    func responseString() async throws(CoreServiceError) -> String {
        let data = try await response()
        
        guard let resultDTO = String(data: data, encoding: .utf8) else {
            throw CoreServiceError(code: .other(code: "DecodingError"), message: "Could not decode data")
        }
        
        return resultDTO
    }
}
