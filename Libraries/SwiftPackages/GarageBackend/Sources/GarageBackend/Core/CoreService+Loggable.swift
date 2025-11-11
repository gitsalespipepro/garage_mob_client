//
//  CoreService+Loggable.swift
//  GarageBackend
//
//  Created by Rezo Joglidze on 11.11.25.
//

import Foundation

import Foundation

extension CoreService {
    func logRequest(_ requests: URLRequest...) {
        requests.forEach {
            Configuration.logger?.log(request: $0)
        }
    }
    
    func logResponse(_ response: URLResponse, data: Data) {
        Configuration.logger?.log(response: response, data: data)
    }
}

public protocol CoreServiceLogger {
    func log(request: URLRequest)
    func log(response: URLResponse, data: Data)
}
