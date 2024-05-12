import Foundation

struct King: Piece {
    let speed: CGFloat = Build.dev ? 10 : 2
    let baseCost: Int = 1
    let id = UUID()
    var position: CGPoint
    var target: CGPoint? = nil

    var team: Team
    
    init(_ team: Team, position: CGPoint) {
        self.team = team
        self.position = position
    }
        
    static func getKingMoves(board: Board, position: CGPoint, team: Team) -> [Move] {
        
        let location = Board.getLocation(at: position)
        var moves: [Move] = []
        let possibleMoves: [Move] = [
            .available(x: location.x + 1, y: location.y + 1),
            .available(x: location.x + 1, y: location.y - 1),
            .available(x: location.x + 1, y: location.y),
            .available(x: location.x, y: location.y - 1),
            .available(x: location.x, y: location.y + 1),
            .available(x: location.x - 1, y: location.y - 1),
            .available(x: location.x - 1, y: location.y + 1),
            .available(x: location.x - 1, y: location.y),
        ]
        outer: for move in possibleMoves {
            for piece in board.pieces{
                if (piece.target == nil && piece.location.x == move.x && piece.location.y == move.y) {
                    if piece.team != team {
                        moves.append(.attack(x: move.x, y: move.y, piece: piece))
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
    
    func getAvailableMoves(board: Board) -> [Move] {
        var enemyMoves: [Move] = []
        var enemyPieces = team == .friend ? board.foePieces : board.friendPieces
        for enemyPiece in enemyPieces {
            if enemyPiece is King {
                enemyMoves.append(contentsOf: King.getKingMoves(board: board, position: enemyPiece.position, team: enemyPiece.team))
            } else if enemyPiece is Pawn {
                enemyMoves.append(contentsOf: Pawn.getPawnAttacks(position: enemyPiece.position, team: enemyPiece.team).map({.available(x: $0.x, y: $0.y)}))
            } else {
                enemyMoves.append(contentsOf: enemyPiece.getAvailableMoves(board: board))
            }
        }
        
        let possibleMoves =  Self.getKingMoves(board: board, position: position, team: team).filter({ possibleMove in
            
            !enemyMoves.contains(possibleMove)
        })
                        
        return possibleMoves
    }

}
