//
//  PostAPI.swift
//  app
//
//  Created by dotn on 8/8/24.
//

import Foundation
import Moya

enum Apis {
    case getUserInfo
    case login(body: Encodable)
}

extension Apis: TargetType, AccessTokenAuthorizable {
    var authorizationType: Moya.AuthorizationType? {
        switch self {
        // UnAuth
        case .login: return .none

        // Auth
        case .getUserInfo: return .bearer
        }
    }

    var baseURL: URL {
        return URL(string: Configs.share.baseUrl)!
    }

    var path: String {
        switch self {
        // UnAuth
        case .login: return "/auth/login"

        // Auth
        case .getUserInfo: return "/auth/me"
        }
    }

    var method: Moya.Method {
        switch self {
        // UnAuth
        case .login: return .post

        // Auth
        case .getUserInfo: return .get
        }
    }

    var task: Moya.Task {
        switch self {
        // UnAuth
        case .login(let body): return .requestJSONEncodable(body)

        // Auth
        case .getUserInfo: return .requestPlain
        }
    }

    var headers: [String: String]? {
        nil
    }
}
