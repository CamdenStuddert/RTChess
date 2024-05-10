import Foundation

struct Queen: Piece {
    let speed: CGFloat = Build.dev ? 10 : 2
    let baseCost: Int = 4
    let id = UUID()
    var position: CGPoint
    var target: CGPoint? = nil
    
    var team: Team
    
    init(_ team: Team, position: CGPoint) {
        self.team = team
        self.position = position
    }
    
    func getAvailableMoves(board: Board) -> [Move] {
        return Bishop.getBishopMoves(board: board, position: position, team: team) + Rook.getRookMoves(board: board, position: position, team: team)
    }
}
