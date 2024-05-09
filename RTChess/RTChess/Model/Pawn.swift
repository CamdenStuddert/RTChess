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
    
    func getAvailableMoves(board: Board) -> [Move] {
        let location = Board.getLocation(at: position)
        
        if team == .white {
            if location.y == 6 {
                var moves: [Move] = []
                let noAttacks: [Move] = [
                    .available(x: location.x,
                    y: location.y - 1),
                    .available(x: location.x,
                    y: location.y - 2)
                ]
                let attacks: [Move] = [
                    .attack(x: location.x + 1, y: location.y - 1),
                    .attack(x: location.x - 1, y: location.y - 1)
                ]
                
            } else if location.y > 0 {
                var moves: [Move] = []
                let noAttacks: [Move] = [
                    .available(x: location.x,
                    y: location.y - 1)
                ]
                let attacks: [Move] = [
                    .attack(x: location.x + 1, y: location.y - 1),
                    .attack(x: location.x - 1, y: location.y - 1)
                ]
            }
        } else {
            if location.y == 1 {
                var moves: [Move] = []
                let noAttacks: [Move] = [
                    .available(x: location.x,
                    y: location.y + 1),
                    .available(x: location.x,
                    y: location.y + 2)
                ]
                let attacks: [Move] = [
                    .attack(x: location.x + 1, y: location.y + 1),
                    .attack(x: location.x - 1, y: location.y + 1)
                ]
            } else if location.y < Board.cells-1 {
                var moves: [Move] = []
                let noAttacks: [Move] = [
                    .available(x: location.x,
                    y: location.y + 1)
                ]
                let attacks: [Move] = [
                    .attack(x: location.x + 1, y: location.y + 1),
                    .attack(x: location.x - 1, y: location.y + 1)
                ]
            }
        }
        
        return []
    }
    
}
