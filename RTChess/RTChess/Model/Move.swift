import Foundation

private protocol MoveProtocol {
    var x: Int {get}
    var y: Int {get}
}

enum Move: MoveProtocol, Equatable {
    var x: Int {
        switch self {
        case let .available(x, _): return x
        case let .attack(x, _, _): return x
        }
    }
    var y: Int {
        switch self {
        case let .available(_, y): return y
        case let .attack(_, y, _): return y
        }
    }
    var location: (x: Int, y: Int) { return (x: x, y: y) }
     
    case available(x: Int, y: Int)
    case attack(x: Int, y: Int, piece: Piece)
    
    static func ==(lhs: Move, rhs: Move) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}
