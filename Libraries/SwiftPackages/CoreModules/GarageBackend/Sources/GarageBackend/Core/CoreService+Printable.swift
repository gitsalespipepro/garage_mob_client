//
//  CoreService+Printable.swift
//  GarageBackend
//
//  Created by Rezo Joglidze on 11.11.25.
//

import Foundation

extension URLRequest {
    public func printCurlEquivalent() {
#if DEBUG
        var curl = "curl -X \(self.httpMethod ?? "GET") '\(self.url?.absoluteString ?? "")'"
        
        self.allHTTPHeaderFields?.forEach { key, value in
            curl += " -H '\(key): \(value)'"
        }
        
        if let body = self.httpBody,
           let bodyString = String(data: body, encoding: .utf8) {
            curl += " -d '\(bodyString)'"
        }
        
        print("📤 cURL:", curl)
#endif
    }
}

extension URLResponse {
    func printMeta(data: Data?) {
#if DEBUG
        print("Response:")
        print("URL: \(url?.absoluteString ?? "")")
        print("HTTP Status Code: \((self as? HTTPURLResponse)?.statusCode ?? -1)")
        if let data, let json = try? JSONSerialization.jsonObject(with: data) {
            print("JSON:")
            print(json)
        } else if let data = data, let string = String(data: data, encoding: .utf8) {
            print("String:")
            print(string)
        }
#endif
    }
    
    func printMetadata(tempUrl: String, fileUrl: String) {
#if DEBUG
        print("Response:")
        print("URL: \(url?.absoluteString ?? "")")
        print("HTTP Status Code: \((self as? HTTPURLResponse)?.statusCode ?? -1)")
        print("Local Url before change: ", tempUrl)
        print("File Url after change: ", tempUrl)
#endif
    }
}
