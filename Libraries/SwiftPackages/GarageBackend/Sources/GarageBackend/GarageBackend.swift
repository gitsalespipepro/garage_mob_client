//
//  GarageBackend.swift
//  GarageBackend
//
//  Created by Rezo Joglidze on 11.11.25.
//

import Foundation

public struct Configuration {
    /// Default error message is displayed if there is no error message coming from a response.
    nonisolated(unsafe) public static let defaultErrorMessage: (() -> String) = { fatalError("defaultErrorMessage implementation is required") }
    
    /// for logging request response
    nonisolated(unsafe) public static let logger: CoreServiceLogger? = nil
}


public extension Configuration {
    enum Authentication {
        /// Invoked once 401 unauthorized status code is received.
        @MainActor public static var didReceive401: (() -> Void) = { fatalError("didReceive401 implementation is required") }
    }
}
