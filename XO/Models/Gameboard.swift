import Foundation

public final class Gameboard {

    // MARK: - Properties

    private lazy var positions: [[Player?]] = initialPositions()

    // MARK: - public

    public func setPlayer(_ player: Player, at position: GameboardPosition) {
        positions[position.column][position.row] = player
    }

    public func clear() {
        self.positions = initialPositions()
    }

    public func contains(player: Player, at positions: [GameboardPosition]) -> Bool {
        for position in positions {
            guard contains(player: player, at: position) else {
                return false
            }
        }
        return true
    }

    public func contains(player: Player, at position: GameboardPosition) -> Bool {
        let (column, row) = (position.column, position.row)
        return positions[column][row] == player
    }

    public var gotAvailablePositions: Bool {
        positions.flatMap { $0 }.contains(nil)
    }

    public func isAvailablePositions(at position: GameboardPosition) -> Bool {
        if positions[position.column][position.row] != Player.first {
            if positions[position.column][position.row] != Player.second {
                return true
            }
        }
        return false
    }

    // MARK: - Private

    private func initialPositions() -> [[Player?]] {
        var positions: [[Player?]] = []
        for _ in 0 ..< GameboardSize.columns {
            let rows = Array<Player?>(repeating: nil, count: GameboardSize.rows)
            positions.append(rows)
        }
        return positions
    }
}
