//
//  CoreService.swift
//
//
//  Created by Rezo Joglidze on 11.11.25.
//

import Combine
import Foundation

public protocol CoreService {
    var urlSession: URLSession { get }
    var configuration: URLSessionConfiguration { get }
  
    func request(url: String, method: HTTPMethod, headers: HeaderParameters?, query: QueryParameters?, body: Encodable?, encoding: ParameterEncoding) async throws(CoreServiceError) -> CoreRequest

    func uploadRequest(url: String, method: HTTPMethod, headers: HeaderParameters?, query: QueryParameters?, body: Encodable?, files: [MediaFile], encoding: ParameterEncoding) async throws(CoreServiceError) -> CoreRequest
    
    func downloadRequest(url: String, method: HTTPMethod, headers: HeaderParameters?, query: QueryParameters?, body: Encodable?, encoding: ParameterEncoding) async throws -> URL
}

public class CoreServiceImpl: CoreService {
    
    private var _urlSession: URLSession?
    public var configuration: URLSessionConfiguration = .default
    
    public init() {}
    
    public var urlSession: URLSession {
        if let _urlSession { return _urlSession }
        let session: URLSession = URLSession(
            configuration: configuration,
            delegate: nil,
            delegateQueue: nil
        )
        configuration.httpShouldSetCookies = false
        _urlSession = session
        return session
    }
    
    func urlRequest(from endpoint: Endpoint) throws(CoreServiceError) -> CoreRequest {
        let urlRequest = try URLRequest(from: endpoint)
        
        urlRequest.printCurlEquivalent()
        self.logRequest(urlRequest)
        
        return CoreRequest(service: self, urlRequest: urlRequest)
    }
}

public struct CoreRequest {
    public let service: CoreService
    public let urlRequest: URLRequest
    
    func response() async throws(CoreServiceError) -> Data {
        do {
            let (data, response) = try await self.service.urlSession.data(for: self.urlRequest)
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            
            response.printMeta(data: data)
            self.service.logResponse(response, data: data)
            
            if statusCode == 401 {
                await MainActor.run {
                    Configuration.Authentication.didReceive401()
                }
            }
            
            guard (200..<300).contains(statusCode) else {
                throw CoreServiceError(httpStatusCode: HTTPStatusCode(rawValue: statusCode), data: data, code: nil, message: nil)
            }
            
            return data
        } catch let error as CoreServiceError {
            throw error
        } catch let error as URLError where error.code == .cancelled {
            throw CoreServiceError(code: .cancelled, message: error.localizedDescription)
        } catch {
            throw CoreServiceError(code: .error, message: error.localizedDescription)
        }
    }
}
