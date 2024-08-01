//
//  CreatePostRequest.swift
//  app
//
//  Created by dotn on 05/08/2024.
//

import Foundation

struct CreatePostParams: Encodable {
    let title: String
    let body: String
    let userId: Int
}

struct CreatePostRequest: EndPoint {
        
    var path: String { return "/posts" }
    
    var method: RequestMethod { return RequestMethod.post }
    
    var encode: HTTPEncode { return HTTPEncode.json }
    
    var body: [String : Any]? {
        return requestBody.toDic()
    }

    var requestBody: CreatePostParams
    
}
