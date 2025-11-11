//
//  CoreService+Error.swift
//  GarageBackend
//
//  Created by Rezo Joglidze on 11.11.25.
//

import Foundation

// MARK: Core Service Error Code
public enum CoreServiceErrorCode: Decodable, Equatable {
    private enum CodingKeys: String, CodingKey {
        case error, cancelled
    }
    
    case error
    case cancelled
    case other(code: String)
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            let rawValue = try container.decode(String.self)
            let codingKey = CodingKeys(rawValue: rawValue)
            switch codingKey {
            case .error: self = .error
            case .cancelled: self = .cancelled
            default:
                let error = NSError(domain: "Couldn't decode CoreServiceErrorCode with rawValue: \(rawValue)", code: .zero)
                print(error)
                self = .other(code: rawValue)
            }
        } catch {
            print(error)
            throw error
        }
    }
}

// MARK: Core Service Error
public struct CoreServiceError {
    public let data: Data?
    public private(set) var code: CoreServiceErrorCode?
    public private(set) var message: String?
    
    private var httpStatusCode: HTTPStatusCode?
    
    public init(
        httpStatusCode: HTTPStatusCode? = nil,
        data: Data? = nil,
        code: CoreServiceErrorCode? = nil,
        message: String? = nil
    ) {
        self.data = data
        self.httpStatusCode = httpStatusCode
        if let data {
            do {
                let error = try JSONDecoder().decode(ErrorModel.self, from: data)
                self.code = error.code
                self.message = error.errors?.joined(separator: ", ")
                if !error.errors.isEmptyOrNil {
                    self.message = error.errors?.joined(separator: ", ") ?? .empty
                }
            } catch {
                print(error)
            }
        }
        
        if let code {
            self.code = code
        }
        if let message {
            self.message = message
        }
        
        if self.message.isEmptyOrNil {
            self.message = Configuration.defaultErrorMessage()
        }
    }
    
    public func decode<T: Decodable>(decoder: JSONDecoder = .init()) -> T? {
        guard let data else { return nil }
        do {
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch {
            print(error)
            return nil
        }
    }
}

extension CoreServiceError: LocalizedError {
    public var errorDescription: String? { message }
}

private extension CoreServiceError {
    struct ErrorModel: Decodable {
        let code: CoreServiceErrorCode?
        let errors: [String]?
        
        enum CodingKeys: String, CodingKey {
            case code
            case errors
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.code = try container.decodeIfPresent(CoreServiceErrorCode.self, forKey: .code)
            self.errors = try container.decodeIfPresent([String].self, forKey: .errors)
        }
    }
}

extension CoreServiceError: Equatable {
    public static func == (lhs: CoreServiceError, rhs: CoreServiceError) -> Bool {
        return lhs.localizedDescription == rhs.localizedDescription
    }
}
