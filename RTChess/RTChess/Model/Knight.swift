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
    
    func getAvailableMoves(board: Board) -> [(x: Int, y: Int)] {
        
        let location = board.getLocation(at: position)
        
        if team == .white {
            if location.y == 7 {
                return [
                    (x: location.x + 1,
                    y: location.y - 2),
                    (x: location.x - 1,
                    y: location.y - 2),
                    (x: location.x + 2,
                     y: location.y - 1),
                    (x: location.x - 2,
                     y: location.y - 1)
                ]
            } else if location.y == 6 {
                return [
                    (x: location.x + 2,
                     y: location.y - 1),
                    (x: location.x - 2,
                     y: location.y - 1),
                    (x: location.x + 2,
                     y: location.y + 1),
                    (x: location.x - 2,
                     y: location.y + 1),
                    (x: location.x - 1,
                     y: location.y - 2),
                    (x: location.x + 1,
                     y: location.y - 2)
                ]
            } else if location.y == 1 {
                return [
                    (x: location.x + 2,
                     y: location.y - 1),
                    (x: location.x - 2,
                     y: location.y - 1),
                    (x: location.x + 2,
                     y: location.y + 1),
                    (x: location.x - 2,
                     y: location.y + 1),
                    (x: location.x - 1,
                     y: location.y + 2),
                    (x: location.x + 1,
                     y: location.y + 2)
                ]
            } else if location.y > 1 && location.y < 6 {
                return [
                    (x: location.x + 1,
                    y: location.y - 2),
                    (x: location.x - 1,
                    y: location.y - 2),
                    (x: location.x + 2,
                     y: location.y - 1),
                    (x: location.x - 2,
                     y: location.y - 1),
                    (x: location.x - 2,
                     y: location.y + 1),
                    (x: location.x + 2,
                     y: location.y + 1),
                    (x: location.x + 1,
                     y:location.y + 2),
                    (location.x - 1,
                     y: location.y + 2)
                ]
            }
        } else{
            if location.y == 0 {
                return [
                    (x: location.x + 1,
                     y: location.y + 2),
                    (x: location.x - 1,
                     y: location.y + 2),
                    (x: location.x + 2,
                     y: location.y + 1),
                    (x: location.x - 2,
                     y: location.y + 1)
                ]
            } else if location.y == 6 {
                return [
                    (x: location.x + 2,
                     y: location.y - 1),
                    (x: location.x - 2,
                     y: location.y - 1),
                    (x: location.x + 2,
                     y: location.y + 1),
                    (x: location.x - 2,
                     y: location.y + 1),
                    (x: location.x - 1,
                     y: location.y - 2),
                    (x: location.x + 1,
                     y: location.y - 2)
                ]
            } else if location.y == 1 {
                return [
                    (x: location.x + 2,
                     y: location.y - 1),
                    (x: location.x - 2,
                     y: location.y - 1),
                    (x: location.x + 2,
                     y: location.y + 1),
                    (x: location.x - 2,
                     y: location.y + 1),
                    (x: location.x - 1,
                     y: location.y + 2),
                    (x: location.x + 1,
                     y: location.y + 2)
                ]
            } else if location.y > 1 && location.y < 6 {
                return [
                    (x: location.x + 1,
                     y: location.y - 2),
                    (x: location.x - 1,
                     y: location.y - 2),
                    (x: location.x + 2,
                     y: location.y - 1),
                    (x: location.x - 2,
                     y: location.y - 1),
                    (x: location.x - 2,
                     y: location.y + 1),
                    (x: location.x + 2,
                     y: location.y + 1),
                    (x: location.x + 1,
                     y:location.y + 2),
                    (location.x - 1,
                     y: location.y + 2)
                ]
            }
        }
        return []
    }
}
