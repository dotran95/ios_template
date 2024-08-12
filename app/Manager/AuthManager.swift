//
//  AuthManager.swift
//  app
//
//  Created by dotn on 13/8/24.
//

import Foundation

class AuthManager {
    
    static let shared = AuthManager()
    
    private init() {}
    
    private let tokenKey = "tokenKey"
    private let userKey = "userKey"
    private let userDefaults = UserDefaults.standard
    
    var token: String? {
        get {
            return userDefaults.value(forKey: tokenKey) as? String
        }
        set {
            return userDefaults.set(newValue, forKey: tokenKey)
        }
    }
    
    var user: UserModel? {
        get {
            guard let data = userDefaults.value(forKey: userKey) as? Data else { return nil }
            guard let user = try? PropertyListDecoder().decode(UserModel.self, from: data) else { return nil }
            return user
        }
        set {
            guard let data = try? PropertyListEncoder().encode(newValue) else { return }
            userDefaults.set(data, forKey: userKey)
        }
    }
    
    func onLogOut() {
        token = nil
        user = nil
        userDefaults.removeObject(forKey: tokenKey)
        userDefaults.removeObject(forKey: userKey)
    }
    
}
