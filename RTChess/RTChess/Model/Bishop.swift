import Foundation

struct Bishop: Piece {
    let speed: CGFloat = 10
    
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
        
        let location = Board.getLocation(at: position)
        var moves: [Move]  = []
        var incrementPlusNum = location.x
        var incrementMinNum = location.x
        
        if(location.y > 0) {
        outer: for diagonallyUpAndLeft in 1...location.y {
            let y = location.y - diagonallyUpAndLeft
            let x = location.x - diagonallyUpAndLeft
            let move = (x: x, y: y)
            
            for piece in board.pieces {
                if (piece.target == nil && piece.location == move) ||
                    piece.targetLocation ?? (x:-1,y:-1) == move {
                    
                    if piece.team != team {
                        moves.append(.attack(x: move.x, y: move.y))
                    }
                    break outer
                }
            }
            
            moves.append(.available(x: move.x, y: move.y))
        }
        }
    outer: for diagnollyUpAndRight in 1...location.x {
        let x = location.x + diagnollyUpAndRight
        let y = location.y - diagnollyUpAndRight
        let move = (x: x, y: y)
        for piece in board.pieces {
            if (piece.target == nil && piece.location == move) ||
                piece.targetLocation ?? (x:-1,y:-1) == move {
                
                if piece.team != team {
                    moves.append(.attack(x: move.x, y: move.y))
                }
                
                break outer
            }
        }
        
        moves.append(.available(x: move.x, y: move.y))
    }
        if location.y == 0 {
            outer: for diagnollyDownAndLeft in (location.y+1)..<Board.cells {
                let move = (x: location.x - diagnollyDownAndLeft, y: diagnollyDownAndLeft)
                for piece in board.pieces {
                    if (piece.target == nil && piece.location == move) ||
                        piece.targetLocation ?? (x:-1,y:-1) == move {
                    
                        if piece.team != team {
                            moves.append(.attack(x: move.x, y: move.y))
                        }
                    
                        break outer
                    }
                }
            
                moves.append(.available(x: move.x, y: move.y))
            }
            outer: for diagnollyDownAndRight in (location.y+1)..<Board.cells {
                let move = (x: location.x + diagnollyDownAndRight, y: diagnollyDownAndRight)
                for piece in board.pieces {
                    if (piece.target == nil && piece.location == move) ||
                        piece.targetLocation ?? (x:-1,y:-1) == move {
                    
                        if piece.team != team {
                            moves.append(.attack(x: move.x, y: move.y))
                        }
                    
                        break outer
                    }
                }
                moves.append(.available(x: move.x, y: move.y))
            }
        }
    outer: for diagnollyDownAndRight in location.y..<Board.cells-1 {
        incrementPlusNum += 1
        
        let move = (x: incrementPlusNum, y: diagnollyDownAndRight + 1)
        for piece in board.pieces {
            if (piece.target == nil && piece.location == move) ||
                piece.targetLocation ?? (x:-1,y:-1) == move {
                if piece.team != team {
                    moves.append(.attack(x: move.x, y: move.y))
                }
                break outer
            }
        }
        moves.append(.available(x: move.x, y: move.y))
    }
    outer: for diagnollyDownAndRight in location.y..<Board.cells-1 {
        incrementMinNum -= 1
        
        let move = (x: incrementMinNum, y: diagnollyDownAndRight + 1)
        for piece in board.pieces {
            if (piece.target == nil && piece.location == move) ||
                piece.targetLocation ?? (x:-1,y:-1) == move {
                if piece.team != team {
                    moves.append(.attack(x: move.x, y: move.y))
                }
                break outer
            }
        }
        moves.append(.available(x: move.x, y: move.y))
    }        
    if(location.x == 0) {
        outer: for negX in 1...location.x {
            let x = location.x + negX
            let move = (x: x, y: location.y)
            for piece in board.pieces {
                if (piece.target == nil && piece.location == move) ||
                    piece.targetLocation ?? (x:-1,y:-1) == move {
                
                    if piece.team != team {
                        moves.append(.attack(x: move.x, y: move.y))
                    }

                break outer
                }
            }

        moves.append(.available(x: move.x, y: move.y))
        }
    }
        
        incrementPlusNum = location.x
        incrementMinNum = location.x
        return moves
    }
}
