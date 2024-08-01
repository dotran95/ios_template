//
//  ApiClient+Logger.swift
//  app
//
//  Created by dotn on 7/8/24.
//

import Foundation

extension URLRequest {
    
    var debugMsg: String {
        var msg = ""
#if DEBUG
        let absoluteString = url?.absoluteString ?? ""
        let method = self.httpMethod ?? ""
        let body = httpBody.map { data in
            return String(data: data, encoding: String.Encoding.utf8) ?? ""
        }
        let headerStr = String(describing: allHTTPHeaderFields)
        
        msg = """
==========================Network===========================
Request:
URL: \(absoluteString)
Method: \(method)
Headers: \(headerStr)
Body: \(String(describing: body))
"""
        
#endif
        return msg
    }
    
    
    func debugLog() {
#if DEBUG
        print(debugMsg)
#endif
    }
}


extension URLResponse {
    
    func debugMsg(data: Data?, error: Error?, printData: Bool = false) -> String {
        var msg = ""
#if DEBUG
        var statusCode = 0
        if let httpUrlResponse = self as? HTTPURLResponse {
            statusCode = httpUrlResponse.statusCode
        }
        
        let dataStr = printData ? "DATA: \(String(describing: data))" : ""
        
        msg = """
RESPONSE:
STATUS CODE: \(statusCode)
DATA: \(dataStr)
ERROR: \(String(describing: error))
"""
#endif
        return msg
    }
    
    func debugLog(data: Data?, error: Error?, printData: Bool = false) {
#if DEBUG
        print(debugMsg(data: data, error: error, printData: printData))
#endif
    }
}
