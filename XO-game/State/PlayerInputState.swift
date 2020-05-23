//
//  PlayerInputState.swift
//  XO-game
//
//  Created by Andrey Antropov on 17.05.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

class PlayerInputState: GameState {
    var currentPlayer: Player? { player }
    
    
    let player: Player
    let markViewPrototype: MarkView
    
    weak var gameViewController: GameViewController?
    var isCompleted: Bool = false
    
    init(player: Player, gameViewController: GameViewController?, markViewPrototype: MarkView) {
        self.player = player
        self.gameViewController = gameViewController
        self.markViewPrototype = markViewPrototype
    }
    
    func begin() {
        switch player {
        case .first:
            gameViewController?.firstPlayerTurnLabel.isHidden = false
            gameViewController?.secondPlayerTurnLabel.isHidden = true
        case .second:
            gameViewController?.firstPlayerTurnLabel.isHidden = true
            gameViewController?.secondPlayerTurnLabel.isHidden = false
        }
        gameViewController?.winnerLabel.isHidden = true
    }
    
    func addMark(at position: GameboardPosition) {
        guard !isCompleted else { return }
        
//        let markView = player == .first ? XView() : OView()
        Logger.shared.did(action: .playerDidAMove(player: player, position: position))
        gameViewController?.gameboardView.placeMarkView(markViewPrototype, at: position)
        gameViewController?.gameboard.setPlayer(player, at: position)
        
        isCompleted = true
    }
}
