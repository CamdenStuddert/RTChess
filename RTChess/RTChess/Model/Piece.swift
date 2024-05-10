import Foundation


protocol Piece {
    
    var id: UUID { get }
    var team: Team { get }
    var moveCost: Float { get }
    
    var speed: CGFloat { get }
    
    var position: CGPoint { get set }
    var target: CGPoint? { get set }

    func getAvailableMoves(board: Board) -> [Move]
    
}

extension Piece {
    var location: (x: Int, y: Int) {
        return Board.getLocation(at: position)
    }
    var targetLocation: (x: Int, y: Int)? {
        guard let target else { return nil }
        return Board.getLocation(at: target)
    }
}
