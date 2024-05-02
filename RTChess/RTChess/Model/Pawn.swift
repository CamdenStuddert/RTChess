import Foundation

struct Pawn: Piece {
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
        let location = board.getLocation(at: position)
        
        if team == .white {
            if location.y == 6 {
                return [
                    (x: location.x,
                    y: location.y - 1),
                    (x: location.x,
                    y: location.y - 2)
                ]
            } else if location.y > 0 {
                return [
                    (x: location.x,
                    y: location.y - 1)
                ]
            }
        } else {
            if location.y == 1 {
                return [
                    (x: location.x,
                    y: location.y + 1),
                    (x: location.x,
                    y: location.y + 2)
                ]
            } else if location.y < Board.cells-1 {
                return [
                    (x: location.x,
                    y: location.y + 1)
                ]
            }
        }
        
        return []
    }
    
}
