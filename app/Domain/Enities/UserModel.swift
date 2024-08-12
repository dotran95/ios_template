//
//  UserModel.swift
//  app
//
//  Created by dotn on 12/8/24.
//

import Foundation

struct UserModel: Codable {
    let id: Int?
    let email, firstName, lastName: String?
    let gender: String?
    let image: String?
    
    static func fromApi(res: GetUserRespose) -> UserModel {
        return UserModel(id: res.id, email: res.email, firstName: res.firstName, lastName: res.lastName, gender: res.gender, image: res.image)
    }
    
    static func fromApi(res: LoginResponse) -> UserModel {
        return UserModel(id: res.id, email: res.email, firstName: res.firstName, lastName: res.lastName, gender: res.gender, image: res.image)
    }

}
