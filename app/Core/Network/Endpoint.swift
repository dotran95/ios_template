//
//  Endpoint.swift
//  app
//
//  Created by dotn on 24/07/2024.
//

import Foundation

enum RequestMethod: String {
    case get
    case post
}

enum HTTPEncode: String {
    case none
    case json
}

protocol EndPoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: RequestMethod { get }
    var encode: HTTPEncode { get }
    var header: [String: String]? { get }
    var body: [String: Any]? { get }
    var queryParams: [String: String]? { get }
    var pathParams: [String: String]? { get }
}


extension EndPoint {
    
    var method: RequestMethod { return RequestMethod.get }
    var encode: HTTPEncode { return HTTPEncode.none }
    var header: [String: String]? { return nil }
    var body: [String: Any]? { return nil }
    var queryParams: [String: String]? { return nil }
    var pathParams: [String: String]? { return nil }

    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    var request: URLRequest  {
        get throws {
            var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
            var newPath = path
            
            if let pathParams = self.pathParams {
                for param in pathParams {
                    newPath = newPath.replacingOccurrences(of: param.key, with: param.value)
                }
            }
            urlComponents.path = newPath
            
            
            if let queryParams = self.queryParams {
                let queryItems = queryParams.map({URLQueryItem(name: $0.key, value: $0.value)})
                urlComponents.queryItems = queryItems
            }
            
            guard let url = urlComponents.url else { throw NetworkUrlCreationError() }
            
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            if let header = self.header {
                header.forEach { (key: String, value: String) in
                    request.setValue(value, forHTTPHeaderField: key)
                }
            }

            if let body = self.body {
                switch encode {
                case .json:
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    let jsonData = try? JSONSerialization.data(withJSONObject: body, options: [])
                    request.httpBody = jsonData
                default:
                    break
                }
            }
            return request
        }
    }
}
