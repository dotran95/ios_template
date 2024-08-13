//
//  String+Extension.swift
//  app
//
//  Created by dotn on 13/8/24.
//

import Foundation

extension String {
    func localized(_ lanCode: String, arguments: [CVarArg] = []) -> String {
        guard
            let bundlePath = Bundle.main.path(forResource: lanCode, ofType: "lproj"),
            let bundle = Bundle(path: bundlePath)
        else { return "" }
        
        let localized = NSLocalizedString(
            self,
            bundle: bundle,
            value: " ",
            comment: ""
        )
        return String(format: localized, locale: nil, arguments: arguments)

    }

}
