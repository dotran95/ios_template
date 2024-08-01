//
//  Codeable+Extension.swift
//  app
//
//  Created by dotn on 7/8/24.
//

import Foundation

extension Encodable {
    func toDic() -> [String: Any]? {
        do {
            let data = try JSONEncoder().encode(self)
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                return nil
            }
            return dictionary
        } catch {
            return nil
        }
    }
}
