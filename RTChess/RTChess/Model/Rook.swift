import Foundation

struct Rook: Piece {
    let speed: CGFloat = Build.dev ? 10 : 2
    let moveCost: Float = 1
    let id = UUID()
    
    var position: CGPoint
    var target: CGPoint? = nil

    var team: Team
    
    init(_ team: Team, position: CGPoint) {
        self.team = team
        self.position = position
    }
        
    func getAvailableMoves(board: Board) -> [Move] {
        if target != nil {return []}
        
        return Self.getRookMoves(board: board, position: position, team: team)
    }
    
    static func getRookMoves(board: Board, position: CGPoint, team: Team) -> [Move] {
        let location = Board.getLocation(at: position)
        var moves: [Move]  = []
        
        if(location.y > 0) {
            outer: for negY in 1...location.y {
                let y = location.y - negY
                let move = (x: location.x, y: y)
                
                for piece in board.pieces {
                    if (piece.target == nil && piece.location == move) ||
                        piece.targetLocation ?? (x:-1,y:-1) == move {
                        
                        if piece.team != team {
                            moves.append(.attack(x: move.x, y: move.y, id: piece.id))
                        }
                        break outer
                    }
                }
                
                moves.append(.available(x: move.x, y: move.y))
            }
        }
        outer: for y in (location.y+1)..<Board.cells {
            let move = (x: location.x, y: y)
            for piece in board.pieces {
                if (piece.target == nil && piece.location == move) ||
                    piece.targetLocation ?? (x:-1,y:-1) == move {
                    
                    if piece.team != team {
                        moves.append(.attack(x: move.x, y: move.y, id: piece.id))
                    }
                    
                    break outer
                }
            }
            
            moves.append(.available(x: move.x, y: move.y))
        }
        
        if(location.x > 0) {
            outer: for negX in 1...location.x {
                let x = location.x - negX
                let move = (x: x, y: location.y)
                for piece in board.pieces {
                    if (piece.target == nil && piece.location == move) ||
                        piece.targetLocation ?? (x:-1,y:-1) == move {
                        
                        if piece.team != team {
                            moves.append(.attack(x: move.x, y: move.y, id: piece.id))
                        }

                        break outer
                    }
                }

                moves.append(.available(x: move.x, y: move.y))
            }
        }
        outer: for x in (location.x+1)..<Board.cells {
            let move = (x: x, y: location.y)
            for piece in board.pieces {
                if (piece.target == nil && piece.location == move) ||
                    piece.targetLocation ?? (x:-1,y:-1) == move {
                    
                    if piece.team != team {
                        moves.append(.attack(x: move.x, y: move.y, id: piece.id))
                    }

                    break outer
                }
            }

            moves.append(.available(x: move.x, y: move.y))
        }

        return moves
    }

}
