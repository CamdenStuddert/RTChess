import Foundation


protocol Piece {
    
    var id: UUID { get }
    var team: Team { get }
    var baseCost: Int { get }
    
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
    
    func cost(to destination: (x: Int, y: Int)) -> Int {
        let moved = max(abs(location.x - destination.x), abs(location.y - destination.y))
        return (moved-1) + baseCost
    }
}
