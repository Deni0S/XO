//
//  Logger.swift
//  XO-game
//
//  Created by Andrey Antropov on 17.05.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

class Logger {
    static let shared = Logger()
    private let lock = NSLock()
    
    private var commands: [LogCommand] = []
    
    public func did(action: LogAction) {
        let command = LogCommand(action: action)
        lock.lock()
        commands.append(command)
        
        if commands.count >= 10 {
            commands.forEach { $0.execute() }
        }
        lock.unlock()
    }
}
