//
//  GameState.swift
//  XO-game
//
//  Created by Andrey Antropov on 17.05.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

protocol GameState {
    func begin()
    func addMark(at position: GameboardPosition)
    
    var isCompleted: Bool { get }
    var currentPlayer: Player? { get }
}
