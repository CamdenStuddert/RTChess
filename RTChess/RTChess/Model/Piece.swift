import Foundation

protocol Piece {
    var team: Team { get }
    
    func getAvailableMoves(board: Board, from position: (x: Int, y: Int))
}


