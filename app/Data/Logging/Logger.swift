//
//  Logger.swift
//  app
//
//  Created by dotn on 8/8/24.

import SwiftyBeaver
import RxSwift

let log = Logger.share

final class Logger {
    
    static let share = Logger()
    
    private let log = SwiftyBeaver.self
    
    private init() {
        let console = ConsoleDestination()  // log to Xcode Console
#if DEBUG
        console.minLevel = .debug
#else
        console.minLevel = 0
#endif
        
        log.addDestination(console)
    }
    
    func debug(_ message: @autoclosure () -> Any, _
               file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
        log.debug(message(), file, function, line: line, context: context)
    }
    
    func info(_ message: @autoclosure () -> Any, _
              file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
        log.info(message(), file, function, line: line, context: context)
    }
    
    func error(_ message: @autoclosure () -> Any, _
               file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
        log.error(message(), file, function, line: line, context: context)
    }
    
    func verbose(_ message: @autoclosure () -> Any, _
                 file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
        log.verbose(message(), file, function, line: line, context: context)
    }
    
    func warning(_ message: @autoclosure () -> Any, _
                 file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
        log.warning(message(), file, function, line: line, context: context)
    }
}
