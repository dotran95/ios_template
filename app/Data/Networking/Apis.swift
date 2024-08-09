//
//  PostAPI.swift
//  app
//
//  Created by VTIT on 8/8/24.
//

import Foundation
import Moya

enum Apis {
    case getUserInfo
}

extension Apis: TargetType, AccessTokenAuthorizable {
    var authorizationType: Moya.AuthorizationType? {
        return .bearer
    }
    
    var baseURL: URL {
        return URL(string: Configs.share.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .getUserInfo: return "/auth/me"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUserInfo: return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getUserInfo: return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    
}
