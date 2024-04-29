import Foundation
import QuartzCore

class Game: ObservableObject {
    
    @Published var board: Board
    
    var updater: CADisplayLink = CADisplayLink()

    init() {
        
        board = Board()
                
        for x in 0..<Board.cells {
            let whitePawn = Pawn(.white, position: CGPoint(x: Board.cellSize * Double(x), y: Board.cellSize * 6))
            board.pieces.append(whitePawn)
            let blackPawn = Pawn(.black, position: CGPoint(x: Board.cellSize * Double(x), y: Board.cellSize))
            board.pieces.append(blackPawn)
            let whiteRook1 = Rook(.white, position: CGPoint(x: Board.cellSize * Double(0), y: Board.cellSize * 7))
            board.pieces.append(whiteRook1)
            let whiteRook2 = Rook(.white, position: CGPoint(x: Board.cellSize * Double(7), y: Board.cellSize * 7))
            board.pieces.append(whiteRook2)
//            let blackRook = Rook(.white, position: CGPoint(x: Board.cellSize * Double(x), y: Board.cellSize))
//            board.pieces.append(blackRook)
//            let whiteKnight = Knight(.white, position: CGPoint(x: Board.cellSize * Double(x), y: Board.cellSize))
//            board.pieces.append(whiteKnight)
//            let blackKnight = Knight(.white, position: CGPoint(x: Board.cellSize * Double(x), y: Board.cellSize))
//            board.pieces.append(blackKnight)
//            let whiteBishop = Bishop(.white, position: CGPoint(x: Board.cellSize * Double(x), y: Board.cellSize))
//            board.pieces.append(whiteBishop)
//            let blackBishop = Bishop(.white, position: CGPoint(x: Board.cellSize * Double(x), y: Board.cellSize))
//            board.pieces.append(blackBishop)
//            let whiteQueen = Queen(.white, position: CGPoint(x: Board.cellSize * Double(x), y: Board.cellSize))
//            board.pieces.append(whiteQueen)
//            let blackQueen = Queen(.white, position: CGPoint(x: Board.cellSize * Double(x), y: Board.cellSize))
//            board.pieces.append(blackQueen)
//            let whiteKing = King(.white, position: CGPoint(x: Board.cellSize * Double(x), y: Board.cellSize))
//            board.pieces.append(whiteKing)
//            let blackKing = King(.white, position: CGPoint(x: Board.cellSize * Double(x), y: Board.cellSize))
//            board.pieces.append(blackKing)
        }
        
        updater = CADisplayLink(target: self, selector: #selector(update))
        updater.preferredFrameRateRange = CAFrameRateRange(minimum: 40, maximum: 60)
        updater.add(to: .current, forMode: .default)
        
    }
    
    
    
    @objc
    func update() {
    
    }
    
}
