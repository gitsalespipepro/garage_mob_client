//
//  File.swift
//  GarageBackend
//
//  Created by Rezo Joglidze on 11.11.25.
//

import Foundation

public enum ParameterEncoding {
    case json
    case urlEncoding
    case queryString
    case httpBody
    case urlEncoded(destination: URLEncodingDestination, arrayEncoding: ArrayEncoding, boolEncoding: BoolEncoding)
    
    public func encode(urlRequest: inout URLRequest, with parameters: BodyParameters) throws {
        switch self {
        case .json:
            try encodeJSON(parameters, into: &urlRequest)
        case .urlEncoding:
            try URLEncoding(destination: .methodDependent, arrayEncoding: .brackets, boolEncoding: .numeric)
                .encode(parameters, into: &urlRequest)
        case .queryString:
            try URLEncoding(destination: .queryString, arrayEncoding: .brackets, boolEncoding: .numeric)
                .encode(parameters, into: &urlRequest)
        case .httpBody:
            try URLEncoding(destination: .httpBody, arrayEncoding: .brackets, boolEncoding: .numeric)
                .encode(parameters, into: &urlRequest)
        case .urlEncoded(let destination, let arrayEncoding, let boolEncoding):
            try URLEncoding(destination: destination, arrayEncoding: arrayEncoding, boolEncoding: boolEncoding)
                .encode(parameters, into: &urlRequest)
        }
    }
    
    private func encodeJSON(_ parameters: BodyParameters, into request: inout URLRequest) throws {
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
    }
}
