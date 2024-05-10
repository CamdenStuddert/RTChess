import Foundation

struct Knight: Piece {
    let speed: CGFloat = Build.dev ? 10 : 3
    let baseCost: Int = 2

    let id = UUID()
    var position: CGPoint
    var target: CGPoint? = nil
    var team: Team
    
    init(_ team: Team, position: CGPoint) {
        self.team = team
        self.position = position
    }
    
    func getAvailableMoves(board: Board) -> [Move] {
        
        let location = Board.getLocation(at: position)
        var moves: [Move] = []
        let possibleMoves: [Move] = [
            .available(x: location.x + 2, y: location.y + 1),
            .available(x: location.x + 2, y: location.y - 1),
            .available(x: location.x + 1, y: location.y + 2),
            .available(x: location.x + 1, y: location.y - 2),
            .available(x: location.x - 2, y: location.y + 1),
            .available(x: location.x - 2, y: location.y - 1),
            .available(x: location.x - 1, y: location.y + 2),
            .available(x: location.x - 1, y: location.y - 2),
        ]
        outer: for move in possibleMoves {
            for piece in board.pieces{
                if (piece.target == nil && piece.location.x == move.x && piece.location.y == move.y) {
                    if piece.team != team {
                        moves.append(.attack(x: move.x, y: move.y, id: piece.id))
                    }
                    continue outer
                }
            }
            if move.y <= (Board.cells - 1) && move.y >= 0 && move.x >= 0 && move.x <= (Board.cells - 1) {
                moves.append(.available(x: move.x, y: move.y))
            }
        }
        return moves
    }
}
