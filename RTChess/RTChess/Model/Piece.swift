import Foundation


protocol Piece {
    var team: Team { get }
    
    var position: CGPoint { get set }
    
    func getAvailableMoves(board: Board)
}


