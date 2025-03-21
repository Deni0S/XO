import Foundation

class BlindPlayerInputState: GameState {
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
        Logger.shared.did(action: .playerDidAMove(player: player, position: position))
        if !(gameViewController?.gameboard.isAvailablePositions(at: position) ?? false) {
            gameViewController?.gameboardView.removeMarkView(at: position)
        }
        gameViewController?.gameboardView.placeMarkView(markViewPrototype, at: position)
        gameViewController?.gameboard.setPlayer(player, at: position)
        isCompleted = true
    }
}
