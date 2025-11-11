//
//  CoreService+Extensions.swift
//  GarageBackend
//
//  Created by Rezo Joglidze on 11.11.25.
//

import Foundation


extension Data {
    @discardableResult
    mutating func append(value: String, encoding: String.Encoding = .utf8) -> Bool {
        if let data = value.data(using: encoding) {
            self.append(data)
            return true
        } else {
            return false
        }
    }
}

extension String {
    static var uuid: String {
        CFUUIDCreateString(kCFAllocatorDefault, CFUUIDCreate(kCFAllocatorDefault)) as String
    }
}
