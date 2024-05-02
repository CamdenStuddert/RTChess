import Foundation

struct Rook: Piece {
    let speed: CGFloat = 1

    let id = UUID()
    var position: CGPoint
    var target: CGPoint? = nil

    var team: Team
    
    init(_ team: Team, position: CGPoint) {
        self.team = team
        self.position = position
    }
    
    func getAvailableMoves(board: Board) -> [(x: Int, y: Int)] {
        return []
    }
    
}
