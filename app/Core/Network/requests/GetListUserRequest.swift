//
//  GetListUserRequest.swift
//  app
//
//  Created by dotn on 05/08/2024.
//

import Foundation

struct GetListUserRequest: EndPoint {
    let page: Int
    let limit: Int
    
    var path: String {
        return "/users"
    }
    
    var queryParams: [String : String]? {
        return [
            "page": "\(page)",
            "limit": "\(limit)"
        ]
    }
    
    init(page: Int = 1, limit: Int = 20) {
        self.page = page
        self.limit = limit
    }
}
