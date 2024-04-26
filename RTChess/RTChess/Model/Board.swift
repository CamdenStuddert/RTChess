import Foundation

struct Board {
    
    static let cells: Int = 8
    static let size: Double = 1000
    static var cellSize: Double {
        Board.size / Double(Board.cells)
    }
    
    var pieces: [Piece] = []
    
    func getPieceAt(position: CGPoint) -> Int? {
        for index in pieces.indices {
            let piece = pieces[index]
            
            if(
                position.x > piece.position.x &&
                position.x < (piece.position.x + Board.cellSize) &&
                position.y > piece.position.y &&
                position.y < (piece.position.y + Board.cellSize)
            ) {
                return index
            }
        }
        
        return nil
    }
    
}

