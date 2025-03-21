import Foundation

class ComputerInputState: GameState {
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.addMark(at: self.randomPosition())
        }
    }

    func addMark(at position: GameboardPosition) {
        guard !isCompleted else { return }
        Logger.shared.did(action: .playerDidAMove(player: player, position: position))
        self.gameViewController?.gameboardView.placeMarkView(self.markViewPrototype, at: position)
        self.gameViewController?.gameboard.setPlayer(self.player, at: position)
        self.isCompleted = true
    }

    func randomPosition() -> GameboardPosition {
        var position: GameboardPosition
        repeat {
            position = GameboardPosition(column: Int.random(in: 0..<GameboardSize.columns), row: Int.random(in: 0..<GameboardSize.rows))
        } while (gameViewController?.gameboard.isAvailablePositions(at: position) != true)
        return position
    }
}
