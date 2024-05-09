import Foundation

struct Knight: Piece {
    let speed: CGFloat = 3
    
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
        for move in possibleMoves {
            for piece in board.pieces{
                if (piece.target == nil && piece.location.x == move.x && piece.location.y == move.y) {
                    if piece.team != team {
                        moves.append(.attack(x: move.x, y: move.y))
                    }
                } else {
                    moves.append(.available(x: move.x, y: move.y))
                }
            }
        }
        return moves
    }
        
//        if location.y == 7 {
//            let moves: [Move] = [
//                .available(x: location.x + 1,
//                           y: location.y - 2),
//                .available(x: location.x - 1,
//                           y: location.y - 2),
//                .available(x: location.x + 2,
//                           y: location.y - 1),
//                .available(x: location.x - 2,
//                           y: location.y - 1)
//            ]
//            
//            return moves
//        } else if location.y == 6 {
//            let moves: [Move] = [
//                .available(x: location.x + 2,
//                           y: location.y - 1),
//                .available(x: location.x - 2,
//                           y: location.y - 1),
//                .available(x: location.x + 2,
//                           y: location.y + 1),
//                .available(x: location.x - 2,
//                           y: location.y + 1),
//                .available(x: location.x - 1,
//                           y: location.y - 2),
//                .available(x: location.x + 1,
//                           y: location.y - 2)
//            ]
//            return moves
//        } else if location.y == 1 {
//            let moves: [Move] = [
//                .available(x: location.x + 2,
//                           y: location.y - 1),
//                .available(x: location.x - 2,
//                           y: location.y - 1),
//                .available(x: location.x + 2,
//                           y: location.y + 1),
//                .available(x: location.x - 2,
//                           y: location.y + 1),
//                .available(x: location.x - 1,
//                           y: location.y + 2),
//                .available(x: location.x + 1,
//                           y: location.y + 2)
//            ]
//            return moves
//        } else if location.y > 1 && location.y < 6 {
//            let moves: [Move] = [
//                .available(x: location.x + 1,
//                           y: location.y - 2),
//                .available(x: location.x - 1,
//                           y: location.y - 2),
//                .available(x: location.x + 2,
//                           y: location.y - 1),
//                .available(x: location.x - 2,
//                           y: location.y - 1),
//                .available(x: location.x - 2,
//                           y: location.y + 1),
//                .available(x: location.x + 2,
//                           y: location.y + 1),
//                .available(x: location.x + 1,
//                           y:location.y + 2),
//                .available(x: location.x - 1,
//                           y: location.y + 2)
//            ]
//            return moves
//        } else if location.y == 0 {
//            let moves: [Move] = [
//                .available(x: location.x + 1,
//                           y: location.y + 2),
//                .available(x: location.x - 1,
//                           y: location.y + 2),
//                .available(x: location.x + 2,
//                           y: location.y + 1),
//                .available(x: location.x - 2,
//                           y: location.y + 1)
//            ]
//            return moves
//        } else if location.y == 6 {
//            let moves: [Move] = [
//                .available(x: location.x + 2,
//                           y: location.y - 1),
//                .available(x: location.x - 2,
//                           y: location.y - 1),
//                .available(x: location.x + 2,
//                           y: location.y + 1),
//                .available(x: location.x - 2,
//                           y: location.y + 1),
//                .available(x: location.x - 1,
//                           y: location.y - 2),
//                .available(x: location.x + 1,
//                           y: location.y - 2)
//            ]
//            return moves
//        } else if location.y == 1 {
//            let moves: [Move] = [
//                .available(x: location.x + 2,
//                           y: location.y - 1),
//                .available(x: location.x - 2,
//                           y: location.y - 1),
//                .available(x: location.x + 2,
//                           y: location.y + 1),
//                .available(x: location.x - 2,
//                           y: location.y + 1),
//                .available(x: location.x - 1,
//                           y: location.y + 2),
//                .available(x: location.x + 1,
//                           y: location.y + 2)
//            ]
//            return moves
//        } else if location.y > 1 && location.y < 6 {
//            let moves: [Move] = [
//                .available(x: location.x + 1,
//                           y: location.y - 2),
//                .available(x: location.x - 1,
//                           y: location.y - 2),
//                .available(x: location.x + 2,
//                           y: location.y - 1),
//                .available(x: location.x - 2,
//                           y: location.y - 1),
//                .available(x: location.x - 2,
//                           y: location.y + 1),
//                .available(x: location.x + 2,
//                           y: location.y + 1),
//                .available(x: location.x + 1,
//                           y:location.y + 2),
//                .available(x:location.x - 1,
//                           y: location.y + 2)
//            ]
//            return moves
//        }
//        return moves
//    }
}
