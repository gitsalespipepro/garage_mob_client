//
//  PropertyValueTuplable.swift
//
//
//  Created by Giorgi Iashvili on 19.07.23.
//

import Foundation

public struct PropertyValueTuple {
    public let property: String
    public let value: Any?
}
public typealias PropertyValueTuples = [PropertyValueTuple]

public struct PropertyValueEncodedTuple {
    public let property: String
    public let value: String?
}
public typealias PropertyValueEncodedTuples = [PropertyValueEncodedTuple]

public protocol PropertyValueTuplable: Encodable {
    func propertyValueTuples() throws -> PropertyValueTuples
    func propertyValueTuples(encoder: JSONEncoder) throws -> PropertyValueTuples
    func propertyValueTuples(options: JSONSerialization.ReadingOptions) throws -> PropertyValueTuples
    func propertyValueTuples(encoder: JSONEncoder, options: JSONSerialization.ReadingOptions) throws -> PropertyValueTuples

    func propertyValueEncodedTuples() throws -> PropertyValueEncodedTuples
    func propertyValueEncodedTuples(encoder: JSONEncoder) throws -> PropertyValueEncodedTuples
    func propertyValueEncodedTuples(options: JSONSerialization.ReadingOptions) throws -> PropertyValueEncodedTuples
    func propertyValueEncodedTuples(encoder: JSONEncoder, options: JSONSerialization.ReadingOptions) throws -> PropertyValueEncodedTuples
}

public extension PropertyValueTuplable {
    func propertyValueTuples() throws -> PropertyValueTuples {
        try propertyValueTuples(encoder: .init(), options: [])
    }

    func propertyValueTuples(encoder: JSONEncoder) throws -> PropertyValueTuples {
        try propertyValueTuples(encoder: encoder, options: [])
    }

    func propertyValueTuples(options: JSONSerialization.ReadingOptions) throws -> PropertyValueTuples {
        try propertyValueTuples(encoder: .init(), options: options)
    }

    func propertyValueTuples(encoder: JSONEncoder = .init(), options: JSONSerialization.ReadingOptions = []) throws -> PropertyValueTuples {
        let data = try encoder.encode(self)
        let json = try JSONSerialization.jsonObject(with: data, options: options)
        guard let json = json as? [String: Any] else {
            let error = NSError(domain: "Failed to generate PropertyValueTuples from: \(self)", code: .zero)
            throw error
        }
        let result = json.map {
            PropertyValueTuple(property: $0.key, value: $0.value)
        }
        return result
    }
}

public extension PropertyValueTuplable {
    func propertyValueEncodedTuples() throws -> PropertyValueEncodedTuples {
        try propertyValueEncodedTuples(encoder: .init(), options: [])
    }

    func propertyValueEncodedTuples(encoder: JSONEncoder) throws -> PropertyValueEncodedTuples {
        try propertyValueEncodedTuples(encoder: encoder, options: [])
    }

    func propertyValueEncodedTuples(options: JSONSerialization.ReadingOptions) throws -> PropertyValueEncodedTuples {
        try propertyValueEncodedTuples(encoder: .init(), options: options)
    }

    func propertyValueEncodedTuples(encoder: JSONEncoder = .init(), options: JSONSerialization.ReadingOptions = []) throws -> PropertyValueEncodedTuples {
        let result = try propertyValueTuples(encoder: encoder, options: options)
        var encodedResult: PropertyValueEncodedTuples = []
        for tuple in result {
            guard let value = tuple.value else { continue }
            let res = encodedValues(from: value).map {
                PropertyValueEncodedTuple(property: tuple.property, value: $0)
            }
            encodedResult.append(contentsOf: res)
        }
        return encodedResult
    }

    private func encodedValues(from value: Any) -> [String] {
        var result: [String] = []
        if let values = value as? [Any] {
            for value in values {
                let values = encodedValues(from: value)
                for value in values {
                    result.append(value)
                }
            }
        } else if let number = value as? NSNumber {
            switch CFGetTypeID(number as CFTypeRef) {
            case CFBooleanGetTypeID():
                result.append("\(number.boolValue)")
            case CFNumberGetTypeID():
                result.append("\(value)")
            default:
                print("Something else")
            }
        } else {
            let value = String(describing: value)
            result.append(value)
        }
        return result
    }
}
