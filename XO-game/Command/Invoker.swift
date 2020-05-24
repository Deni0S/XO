//
//  Invoker.swift
//  XO-game
//
//  Created by Денис Баринов on 24.5.20.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

// Объект, который хранит команды и ставит их на исполнение (контроллер для команд).
class Invoker {
    var receiver = Receiver()
    var commands: [Command] = []
    
    func work(gameViewController: GameViewController) {
        let firstPlayer = FirstPlayer()
        let secondPlayer = SecondPlayer()
        let referee = RefereeGame()
        firstPlayer.receiver = self.receiver
        secondPlayer.receiver = self.receiver
        referee.receiver = self.receiver
        self.commands = [firstPlayer, secondPlayer, firstPlayer, secondPlayer]
        for _ in 0..<gameViewController.maxCountMotion-2 {
            self.commands += [firstPlayer, referee, secondPlayer, referee]
        }
        self.commands.forEach { $0.execute(gameViewController: gameViewController) }
    }
}
