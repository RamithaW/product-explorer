//
//  Logger.swift
//  Adidas Challenge
//
//  Created by Ramitha Wirasinha on 3/28/21.
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import Foundation
import SwiftyBeaver

public enum LogLevel: Int {
    case error, warning, success, info, custom, bug, debug
}

public class Logger {
    
    static let sharedInstance: Logger = Logger()
    
    // SwiftyBeaver logging
    let log = SwiftyBeaver.self
    
    var verbosityLevel: LogLevel = .custom
    var enabled: Bool = true
    
    fileprivate static let errorEmoji: String = "🚫"
    fileprivate static let warningEmoji: String = "⚠️"
    fileprivate static let successEmoji: String = "✅"
    fileprivate static let infoEmoji: String = "ℹ️"
    fileprivate static let customEmoji: String = "🔶"
    fileprivate static let bugEmoji: String = "🐛"
    fileprivate static let debugEmoji: String = "🔧"

    init() {
        let console = ConsoleDestination()  // log to Xcode Console
        
        log.addDestination(console)
    }
        
    open class func debug (_ message: String) {
        Logger.sharedInstance.log.debug(message)
    }
    
    open class func info (_ message: String) {
        Logger.sharedInstance.log.info(message)
    }
    
    open class func warning (_ message: String) {
        Logger.sharedInstance.log.warning(message)
    }
    
    open class func error (_ message: String) {
        Logger.sharedInstance.log.error(message)
    }

    fileprivate static let timestampDateTimeFormatter: DateFormatter = {
        
        var formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSS"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        return formatter
    }()
    
    fileprivate class func getTimestamp() -> String {
        return Logger.timestampDateTimeFormatter.string(from: Date())
    }
    
}

