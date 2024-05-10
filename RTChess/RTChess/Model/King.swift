import Foundation

struct King: Piece {
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
        return []
    }
}
