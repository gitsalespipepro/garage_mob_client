//
//  CoreService+Request.swift
//  GarageBackend
//
//  Created by Rezo Joglidze on 11.11.25.
//

import Foundation

extension CoreServiceImpl {
    // MARK: Request
    public func request(
        url: String,
        method: HTTPMethod,
        headers: HeaderParameters?,
        query: QueryParameters?,
        body: Encodable?,
        encoding: ParameterEncoding
    ) async throws(CoreServiceError) -> CoreRequest {
        
        let endpoint = Endpoint(
            path: url,
            query: query ?? [],
            method: method,
            headers: self.headers(with: headers ?? [:]),
            body: self.encodableToDictionary(body) ?? [:],
            parameterEncoding: encoding
        )
        
        configuration.httpShouldSetCookies = false
        configuration.httpCookieStorage = nil
        HTTPCookieStorage.shared.cookies?.forEach(HTTPCookieStorage.shared.deleteCookie)
        
        return try self.urlRequest(from: endpoint)
    }
    
    // MARK: Upload Request
    public func uploadRequest(
        url: String,
        method: HTTPMethod,
        headers: HeaderParameters?,
        query: QueryParameters?,
        body: Encodable? = nil,
        files: [MediaFile],
        encoding: ParameterEncoding = .json
    ) async throws(CoreServiceError) -> CoreRequest {
        
        let endpoint = Endpoint(
            path: url,
            query: query ?? [],
            method: method,
            headers: self.headers(with: headers ?? [:]),
            body: self.encodableToDictionary(body) ?? [:],
            parameterEncoding: encoding,
            files: files
        )
        
        configuration.httpShouldSetCookies = false
        configuration.httpCookieStorage = nil
        HTTPCookieStorage.shared.cookies?.forEach(HTTPCookieStorage.shared.deleteCookie)
        
        return try self.urlRequest(from: endpoint)
    }
    
    // MARK: Download Request
    public func downloadRequest(
        url: String,
        method: HTTPMethod,
        headers: HeaderParameters?,
        query: QueryParameters?,
        body: Encodable?,
        encoding: ParameterEncoding
    ) async throws -> URL {
        let endpoint = Endpoint(
            path: url,
            query: query ?? [],
            method: method,
            headers: self.headers(with: headers ?? [:]),
            body: self.encodableToDictionary(body) ?? [:],
            parameterEncoding: encoding
        )
        
        configuration.httpShouldSetCookies = false
        configuration.httpCookieStorage = nil
        HTTPCookieStorage.shared.cookies?.forEach(HTTPCookieStorage.shared.deleteCookie)
        
        let request = try urlRequest(from: endpoint)
        request.urlRequest.printCurlEquivalent()
        
        // Download with URLSession
        let (tempURL, response) = try await request.service.urlSession.download(for: request.urlRequest)
        
        response.printMetadata(tempUrl: tempURL.absoluteString, fileUrl: "")
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let filename = fileName(from: httpResponse) ?? tempURL.lastPathComponent
        
        // Move to caches directory (like Alamofire’s suggestedDownloadDestination)
        let fileManager = FileManager.default
        let cachesDir = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let fileURL = cachesDir.appendingPathComponent(filename)
        
        try? fileManager.removeItem(at: fileURL) // Remove previous file
        try fileManager.moveItem(at: tempURL, to: fileURL)
        
        response.printMetadata(tempUrl: tempURL.absoluteString, fileUrl: fileURL.absoluteString)
        return fileURL
    }
    
    private func fileName(from httpResponse: HTTPURLResponse) -> String? {
        let pattern = #"filename="?([^";]+)"?"#
        let contentDisposition = httpResponse.value(forHTTPHeaderField: "Content-Disposition")
        
        return contentDisposition
            .flatMap { header -> String? in
                return try? NSRegularExpression(pattern: pattern)
                    .firstMatch(in: header,
                                range: NSRange(header.startIndex..., in: header)
                    ).flatMap {
                        Range($0.range(at: 1), in: header)
                            .map { String(header[$0]) }
                    }
            }
    }
}
