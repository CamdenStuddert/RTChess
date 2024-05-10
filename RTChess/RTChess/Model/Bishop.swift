import Foundation

struct Bishop: Piece {
    let speed: CGFloat = Build.dev ? 10 : 2
    let baseCost: Int = 3
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

        return Self.getBishopMoves(board: board, position: position, team: team)
    }
    
    static func getBishopMoves(board: Board, position: CGPoint, team: Team) -> [Move] {
        
        let location = Board.getLocation(at: position)
        var moves: [Move]  = []
        
        let minTopLeft = min(location.x, location.y)
        if(minTopLeft > 0) {
            outer: for neg in 1...minTopLeft {
                let y = location.y - neg
                let x = location.x - neg
                let move = (x: x, y: y)
                
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
        
        let minTopRight = min(Board.cells - 1 - location.x, location.y)
        if(minTopRight > 0) {
            outer: for neg in 1...minTopRight {
                let y = location.y - neg
                let x = location.x + neg
                let move = (x: x, y: y)
                
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
        
        let minBottomLeft = min(location.x, Board.cells - 1 - location.y)
        if(minBottomLeft > 0) {
            outer: for neg in 1...minBottomLeft {
                let y = location.y + neg
                let x = location.x - neg
                let move = (x: x, y: y)

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

        let minBottomRight = min(Board.cells - location.x, Board.cells - 1 - location.y)
        if(minBottomRight > 0) {
            outer: for neg in 1...minBottomRight {
                let y = location.y + neg
                let x = location.x + neg
                let move = (x: x, y: y)
                
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

        return moves
    }
}
