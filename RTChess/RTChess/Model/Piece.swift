import Foundation


protocol Piece {
    
    var id: UUID { get }
    var team: Team { get }
    
    var speed: CGFloat { get }
    
    var position: CGPoint { get set }
    var target: CGPoint? { get set }

    func getAvailableMoves(board: Board) -> [(x: Int, y: Int)]
    
}
