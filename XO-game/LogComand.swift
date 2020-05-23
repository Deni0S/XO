//
//  LogComand.swift
//  XO-game
//
//  Created by Andrey Antropov on 17.05.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

enum LogAction {
    case playerDidAMove(player: Player, position: GameboardPosition)
    case gameFinished(winner: Player?)
    case restartGame
}

final class LogCommand {
    
    let action: LogAction
    
    init(action: LogAction) {
        self.action = action
    }
    
    var logMessage: String {
        switch action {
        case let .playerDidAMove(player, position):
            return "\(player) placed a mark at \(position)"
        case let .gameFinished(winner):
            return winner != nil ? "\(winner!) won the game" : "Draw"
        case .restartGame:
            return "Game was restarted"
        }
    }
    
    func execute() {
        print(logMessage)
    }
}
