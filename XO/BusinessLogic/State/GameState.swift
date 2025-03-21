import Foundation

protocol GameState {
    func begin()
    func addMark(at position: GameboardPosition)
    
    var isCompleted: Bool { get }
    var currentPlayer: Player? { get }
}
