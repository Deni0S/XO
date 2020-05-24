//
//  Command.swift
//  XO-game
//
//  Created by Денис Баринов on 24.5.20.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

// Непосредственно объект команды, он инкапсулирует действие, которое должно быть выполнено позднее.
protocol Command {
    func execute(gameViewController: GameViewController)
}

class FirstPlayer: Command {
    weak var receiver: Receiver?
    
    func execute(gameViewController: GameViewController) {
        self.receiver?.motion(gameViewController: gameViewController, player: .first)
    }
}

class SecondPlayer: Command {
    weak var receiver: Receiver?

    func execute(gameViewController: GameViewController) {
        self.receiver?.motion(gameViewController: gameViewController, player: .second)
    }
}

class RefereeGame: Command {
    weak var receiver: Receiver?

    func execute(gameViewController: GameViewController) {
        self.receiver?.motion(gameViewController: gameViewController, player: nil)
    }
}



