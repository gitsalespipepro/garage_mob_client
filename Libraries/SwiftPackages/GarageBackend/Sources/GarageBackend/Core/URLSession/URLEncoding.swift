//
//  URLEncoding.swift
//  GarageBackend
//
//  Created by Rezo Joglidze on 11.11.25.
//

import Foundation

public enum URLEncodingDestination {
    case methodDependent
    case queryString
    case httpBody
}

public enum ArrayEncoding {
    case brackets
    case noBrackets
}

public enum BoolEncoding {
    case numeric
    case literal
}

struct URLEncoding {
    let destination: URLEncodingDestination
    let arrayEncoding: ArrayEncoding
    let boolEncoding: BoolEncoding

    init(destination: URLEncodingDestination = .methodDependent,
         arrayEncoding: ArrayEncoding = .brackets,
         boolEncoding: BoolEncoding = .numeric) {
        self.destination = destination
        self.arrayEncoding = arrayEncoding
        self.boolEncoding = boolEncoding
    }

    func encode(_ parameters: BodyParameters, into request: inout URLRequest) throws {
        let query = try self.query(parameters)
        if shouldEncodeParametersInURL(for: request) {
            if var urlComponents = URLComponents(url: request.url!, resolvingAgainstBaseURL: false) {
                let percentEncodedQuery = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "") + query
                urlComponents.percentEncodedQuery = percentEncodedQuery
                request.url = urlComponents.url
            }
        } else {
            request.httpBody = query.data(using: .utf8)
            request.setValue(NetworkKeys.applicationUrlEncoded, forHTTPHeaderField: NetworkKeys.contentType)
        }
    }

    private func shouldEncodeParametersInURL(for request: URLRequest) -> Bool {
        switch destination {
        case .queryString:
            return true
        case .httpBody:
            return false
        case .methodDependent:
            guard let method = request.httpMethod else { return false }
            return ["GET", "HEAD", "DELETE"].contains(method.uppercased())
        }
    }

    private func query(_ parameters: BodyParameters) throws -> String {
        var components: [(String, String)] = []
        for (key, value) in parameters {
            components += queryComponents(fromKey: key, value: value)
        }
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }

    private func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
        var components: [(String, String)] = []

        if let dictionary = value as? [String: Any] {
            for (nestedKey, value) in dictionary {
                components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
            }
        } else if let array = value as? [Any] {
            for value in array {
                let arrayKey = arrayEncoding == .brackets ? "\(key)[]" : key
                components += queryComponents(fromKey: arrayKey, value: value)
            }
        } else if let bool = value as? Bool {
            let boolString = boolEncoding == .numeric ? (bool ? "1" : "0") : (bool ? "true" : "false")
            components.append((escape(key), escape(boolString)))
        } else {
            components.append((escape(key), escape("\(value)")))
        }

        return components
    }

    private func escape(_ string: String) -> String {
        let generalDelimitersToEncode = ":#[]@"
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: generalDelimitersToEncode + subDelimitersToEncode)

        return string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? string
    }
}
