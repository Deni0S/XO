//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    let firstPlayerMarkViewPrototype: XView = {
        let markView = XView()
        markView.lineColor = .green
        markView.lineWidth = 5
        return markView
    }()
    
    let secondPlayerMarkViewPrototype: OView = {
        let markView = OView()
        markView.lineColor = .red
        markView.lineWidth = 10
        return markView
    }()
    
    let gameboard = Gameboard()
    var currentState: GameState! {
        didSet {
            currentState.begin()
        }
    }
    lazy var referee = Referee(gameboard: self.gameboard)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            self.currentState.addMark(at: position)
            self.switchToNextState()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        currentState = PlayerInputState(player: .first, gameViewController: self, markViewPrototype: firstPlayerMarkViewPrototype.copy())
    }
    
    private func switchToNextState() {
        guard currentState.isCompleted else { return }
        
        if let winner = referee.determineWinner() {
            currentState = GameFinishedState(player: winner, gameViewController: self)
        } else if !gameboard.gotAvailablePositions {
            currentState = GameFinishedState(player: nil, gameViewController: self)
        } else if let nextPlayer = currentState.currentPlayer?.next {
            let markView: MarkView = nextPlayer == .first ? firstPlayerMarkViewPrototype.copy() : secondPlayerMarkViewPrototype.copy()
            currentState = PlayerInputState(player: nextPlayer, gameViewController: self, markViewPrototype: markView)
        }
    }
    
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        Logger.shared.did(action: .restartGame)
        gameboard.clear()
        gameboardView.clear()
        currentState = PlayerInputState(player: .first, gameViewController: self, markViewPrototype: firstPlayerMarkViewPrototype.copy())
    }
}

