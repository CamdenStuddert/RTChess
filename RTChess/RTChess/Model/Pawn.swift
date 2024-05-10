import Foundation

struct Pawn: Piece {
    let speed: CGFloat = Build.dev ? 10 : 1
    let baseCost: Int = 1
    let id = UUID()
    
    var position: CGPoint
    var target: CGPoint? = nil {
        didSet {
            moved = true
        }
    }
    
    var moved = false

    var team: Team
    
    init(_ team: Team, position: CGPoint) {
        self.team = team
        self.position = position
    }
    
    func getAvailableMoves(board: Board) -> [Move] {
        let location = Board.getLocation(at: position)
        var moves: [Move] = []

        let multiplier = team == .white ? -1 : 1
        
        var possibleMoves: [Move] = [.available(x: location.x, y: location.y + multiplier)]
        if !moved {
            possibleMoves.append(.available(x: location.x, y: location.y + (multiplier * 2)))
        }

        let possibleAttacks: [(x: Int, y: Int)] = [
            (x: location.x-1, y: location.y + multiplier),
            (x: location.x+1, y: location.y + multiplier)
        ]

        outer: for move in possibleMoves {
            for piece in board.pieces{
                if (piece.target == nil && piece.location.x == move.x && piece.location.y == move.y) {
                    break outer
                }
            }
            if move.y <= (Board.cells - 1) && move.y >= 0 && move.x >= 0 && move.x <= (Board.cells - 1) {
                moves.append(move)
            }
        }
        outer: for attack in possibleAttacks {
            for piece in (team == .white ? board.blackPieces : board.whitePieces) {
                if (piece.target == nil && piece.location.x == attack.x && piece.location.y == attack.y) {
                    moves.append(.attack(x: attack.x, y: attack.y, id: piece.id))
                    continue
                }
            }
        }
        return moves
    }
    
}
