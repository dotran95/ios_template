//
//  ApiResponse.swift
//  app
//
//  Created by dotn on 24/07/2024.
//

import Foundation

struct NetworkRequestError: Error {
    static let code = 997
    let error: Error?
    
    var localizedDescription: String {
        return error?.localizedDescription ?? "Network request error - no other information"
    }
    
    init(error: Error = NSError(domain: "", code: code, userInfo: nil)){
        self.error = error
    }
}

struct NetworkUrlCreationError: Error {
    static let code = 998
    
    let error: Error?
    
    var localizedDescription: String {
        return error?.localizedDescription ?? "Network request error - URL creation error "
    }
    
    init(error: Error = NSError(domain: "", code: code, userInfo: nil)){
        self.error = error
    }

}


struct ApiError: Error {
    let statusCode: Int
}

struct ApiParseError: Error {
    static let code = 999
    
    let error: Error
    var localizedDescription: String {
        return error.localizedDescription
    }
}

struct ApiResponse<T: Decodable> {
    let entity: T?
    let statusCode: Int
    let data: Data?
    
    init(_ objectType: T.Type, data: Data?, httpUrlResponse: HTTPURLResponse) throws {
        self.statusCode = httpUrlResponse.statusCode
        self.data = data
        do {
            self.entity = try JSONDecoder().decode(objectType, from: data ?? Data())
        } catch {
            throw ApiParseError(error: error)
        }
    }
}

struct VoidResponse: Decodable { }
