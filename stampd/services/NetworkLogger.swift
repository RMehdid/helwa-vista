//
//  NetworkLogger.swift
//  stampd
//
//  Created by Mehdid, Samy Abderraouf on 23.02.26.
//
import Foundation

final class LoggingURLProtocol: URLProtocol {
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        let start = Date()
        
        print("🚀 REQUEST: \(request.httpMethod ?? "") \(request.url?.absoluteString ?? "")")
        print("Headers:", request.allHTTPHeaderFields ?? [:])
        
        if let body = request.httpBody,
           let bodyString = String(data: body, encoding: .utf8) {
            print("Body:", bodyString)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            let duration = Date().timeIntervalSince(start)
            
            if let httpResponse = response as? HTTPURLResponse {
                print("✅ RESPONSE: \(httpResponse.statusCode) (\(duration)s)")
            }
            
            if let data,
               let responseString = String(data: data, encoding: .utf8) {
                print("Response Body:", responseString)
            }
            
            if let error {
                print("❌ ERROR:", error.localizedDescription)
            }
            
            if let response = response {
                self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            
            if let data = data {
                self.client?.urlProtocol(self, didLoad: data)
            }
            
            self.client?.urlProtocolDidFinishLoading(self)
        }
        
        task.resume()
    }
    
    override func stopLoading() {}
}
