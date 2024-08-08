//
//  Configs.swift
//  app
//
//  Created by VTIT on 8/8/24.
//

import Foundation

class Configs {
    
    static let share = Configs()
    
    let baseUrl: String
    
    let loggingEnabled = false
    
    private init() {
        guard let baseUrl =
                Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String
        else { fatalError("BASE_URL not found") }
        
        self.baseUrl = baseUrl
    }
    
}
