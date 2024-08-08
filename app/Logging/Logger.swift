//
//  Logger.swift
//  app
//
//  Created by VTIT on 8/8/24.
import SwiftyBeaver

class Logger {
    
    static let share = SwiftyBeaver.self
    
    static func setup() {
        #if DEBUG
        let console = ConsoleDestination()  // log to Xcode Console
        let file = FileDestination()  // log to default swiftybeaver.log file
        // use custom format and set console output to short time, log level & message
        console.format = "$DHH:mm:ss$d $L $M"
        
        log.addDestination(console)
        log.addDestination(file)
        #endif
        
    }
}
