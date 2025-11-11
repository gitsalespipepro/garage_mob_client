//
//  Optional+Extensions.swift
//  GarageBackend
//
//  Created by Rezo Joglidze on 11.11.25.
//

import Foundation

extension Optional where Wrapped : Collection {
    var isEmptyOrNil: Bool {
        return self?.isEmpty ?? true
    }
}
