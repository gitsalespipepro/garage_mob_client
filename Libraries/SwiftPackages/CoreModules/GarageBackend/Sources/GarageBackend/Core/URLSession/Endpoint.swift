//
//  Endpoint.swift
//  GarageBackend
//
//  Created by Rezo Joglidze on 11.11.25.
//

import Foundation

public struct Endpoint {
    var path: String
    var query: QueryParameters = []
    var method: HTTPMethod = .get
    var headers: HeaderParameters = [:]
    var body: BodyParameters = [:]
    var parameterEncoding: ParameterEncoding
    var files: [MediaFile]?
    var cachePolicy: URLRequest.CachePolicy?
    var timeoutInterval: TimeInterval?
    
    public init(
        path: String,
        query: QueryParameters,
        method: HTTPMethod,
        headers: HeaderParameters,
        body: BodyParameters,
        parameterEncoding: ParameterEncoding = .json,
        files: [MediaFile]? = nil,
        cachePolicy: URLRequest.CachePolicy? = nil,
        timeoutInterval: TimeInterval? = nil
    ) {
        self.path = path
        self.query = query
        self.method = method
        self.headers = headers
        self.body = body
        self.parameterEncoding = parameterEncoding
        self.files = files
        self.cachePolicy = cachePolicy
        self.timeoutInterval = timeoutInterval
    }
}

extension Endpoint {
    
    private func pathWithQuery() -> String? {
        guard !query.isEmpty else { return path }
        var urlComponents = URLComponents(string: path)
        urlComponents?.queryItems = query
        return urlComponents?.url?.absoluteString
    }
    
    var url: URL? {
        let allowedCharacterSet = CharacterSet.urlHostAllowed.union(.urlPathAllowed).union(.urlQueryAllowed)
        guard let urlString = pathWithQuery() else { return nil }
        guard let url = urlString.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) else { return nil }
        return URL(string: url)
    }
}

extension URLRequest {
    init(from endpoint: Endpoint) throws(CoreServiceError) {
        
        guard let url = endpoint.url else { throw CoreServiceError() }
        
        self.init(url: url)
        
        try setParameters(
            headers: endpoint.headers,
            body: endpoint.body,
            method: endpoint.method,
            files: endpoint.files,
            cachePolicy: endpoint.cachePolicy,
            encoding: endpoint.parameterEncoding,
            timeoutInterval: endpoint.timeoutInterval
        )
    }
    
    private mutating func setParameters(headers: HeaderParameters,
                                        body: BodyParameters,
                                        method: HTTPMethod,
                                        files: [MediaFile]?,
                                        cachePolicy: URLRequest.CachePolicy?,
                                        encoding: ParameterEncoding,
                                        timeoutInterval: TimeInterval?
    ) throws(CoreServiceError) {
        
        httpMethod = method.rawValue
        
        if let cachePolicy {
            self.cachePolicy = cachePolicy
        }
        
        if let timeoutInterval {
            self.timeoutInterval = timeoutInterval
        }
        
        for (headerField, headerValue) in headers {
            setValue(headerValue, forHTTPHeaderField: headerField)
        }
        
        if let files {
            let boundary = String.uuid
            setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            httpBody = createDataBody(withParameters: body, files: files, boundary: boundary)
        } else if !body.isEmpty {
            do {
                try encoding.encode(urlRequest: &self, with: body)
            } catch {
                throw CoreServiceError(code: .other(code: "encodingError"), message: "http body encoding error")
            }
        }
    }
    
    private func createDataBody(withParameters parameters: BodyParameters, files: [MediaFile], boundary: String) -> Data {
        let lineBreak = "\r\n"
        
        var body = Data()
        
        for (key, value) in parameters {
            body.append(value: "--\(boundary + lineBreak)")
            body.append(value: "Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
            body.append(value: "\(value as! String + lineBreak)")
        }
        
        for file in files {
            body.append(value: "--\(boundary + lineBreak)")
            body.append(value: "Content-Disposition: form-data; name=\"\(file.key)\"\(file.name == nil ? "" : "; filename=\"\(file.name!)\"")\r\n")
            if let type = file.type {
                body.append(value: "Content-Type: \(type + lineBreak + lineBreak)")
            }
            body.append(file.data)
            body.append(value: lineBreak)
        }
        body.append(value: "--\(boundary)--\(lineBreak)")

        return body
    }

}
