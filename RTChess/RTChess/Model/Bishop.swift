import Foundation

struct Bishop: Piece {
    var position: CGPoint
    var team: Team
    
    init(_ team: Team, position: CGPoint) {
        self.team = team
        self.position = position
    }
    
    func getAvailableMoves(board: Board) {
        
    }
}
