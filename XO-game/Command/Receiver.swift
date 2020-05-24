//
//  Receiver.swift
//  XO-game
//
//  Created by Денис Баринов on 24.5.20.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

// Объект, который получает команды, именно он делает всю основную работу.
class Receiver {
    
    func motion(gameViewController: GameViewController, player: Player?) {
        switch player {
        case .some(.first):
            gameViewController.currentState = BlindPlayerInputState(player: .first, gameViewController: gameViewController, markViewPrototype: gameViewController.firstPlayerMarkViewPrototype.copy())
            if gameViewController.firstPlayerMotion.count > 0 {
                gameViewController.currentState.addMark(at: gameViewController.firstPlayerMotion.first!)
                gameViewController.firstPlayerMotion.removeFirst()
                
            }
//            sleep(1)
        case .some(.second):
            gameViewController.currentState = BlindPlayerInputState(player: .second, gameViewController: gameViewController, markViewPrototype: gameViewController.secondPlayerMarkViewPrototype.copy())
            if gameViewController.secondPlayerMotion.count > 0 {
                gameViewController.currentState.addMark(at: gameViewController.secondPlayerMotion.first!)
                gameViewController.secondPlayerMotion.removeFirst()
            }
//            sleep(1)
        case .none:
            if let winner = gameViewController.referee.determineWinner() {
                gameViewController.currentState = GameFinishedState(player: winner, gameViewController: gameViewController)
            } else if gameViewController.secondPlayerMotion.count == 0 {
                gameViewController.currentState = GameFinishedState(player: nil, gameViewController: gameViewController)
            }
        }
    }
}
