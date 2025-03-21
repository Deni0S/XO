import Foundation

public enum Player: CaseIterable {
    case first
    case second

    var next: Player {
        switch self {
        case .first:
            return .second
        case .second:
            return .first
        }
    }
}
