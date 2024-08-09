//
//  ViewModelType.swift
//  app
//
//  Created by VTIT on 9/8/24.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}

class ViewModel {
    
    deinit {
        logger.debug("\(type(of: self)): Deinited")
    }
}
