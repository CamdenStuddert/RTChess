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
    
    static func getPawnAttacks(position: CGPoint, team: Team) -> [(x: Int, y: Int)] {
        let location = Board.getLocation(at: position)
        let multiplier = team == .friend ? -1 : 1
        return [
            (x: location.x-1, y: location.y + multiplier),
            (x: location.x+1, y: location.y + multiplier)
        ]
    }
    
    func getAvailableMoves(board: Board) -> [Move] {
        if target != nil {return []}

        let location = Board.getLocation(at: position)
        var moves: [Move] = []

        let multiplier = team == .friend ? -1 : 1
        
        var possibleMoves: [Move] = [.available(x: location.x, y: location.y + multiplier)]
        if !moved {
            possibleMoves.append(.available(x: location.x, y: location.y + (multiplier * 2)))
        }

        let possibleAttacks: [(x: Int, y: Int)] = Self.getPawnAttacks(position: position, team: team)

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
            for piece in (team == .friend ? board.foePieces : board.friendPieces) {
                if (piece.target == nil && piece.location.x == attack.x && piece.location.y == attack.y) {
                    moves.append(.attack(x: attack.x, y: attack.y, piece: piece))
                    continue
                }
            }
        }
        return moves
    }
    
}
