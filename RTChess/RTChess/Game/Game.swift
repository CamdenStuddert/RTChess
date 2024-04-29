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
        }
        
        //The Doubles are to position the pieces on an 8x8 Grid
        
        let whiteRook1 = Rook(.white, position: CGPoint(x: Board.cellSize * Double(0), y: Board.cellSize * 7))
        board.pieces.append(whiteRook1)
        let whiteRook2 = Rook(.white, position: CGPoint(x: Board.cellSize * Double(7), y: Board.cellSize * 7))
        board.pieces.append(whiteRook2)
        
        
        let blackRook1 = Rook(.black, position: CGPoint(x: Board.cellSize * Double(0), y: Board.cellSize * 0))
        board.pieces.append(blackRook1)
        let blackRook2 = Rook(.black, position: CGPoint(x: Board.cellSize * Double(7), y: Board.cellSize * 0))
        board.pieces.append(blackRook2)
        
        
        let whiteKnight1 = Knight(.white, position: CGPoint(x: Board.cellSize * Double(1), y: Board.cellSize * 7))
        board.pieces.append(whiteKnight1)
        let whiteKnight2 = Knight(.white, position: CGPoint(x: Board.cellSize * Double(6), y: Board.cellSize * 7))
        board.pieces.append(whiteKnight2)
        
        
        let blackKnight1 = Knight(.black, position: CGPoint(x: Board.cellSize * Double(1), y: Board.cellSize * 0))
        board.pieces.append(blackKnight1)
        let blackKnight2 = Knight(.black, position: CGPoint(x: Board.cellSize * Double(6), y: Board.cellSize * 0))
        board.pieces.append(blackKnight2)
        
        
        let whiteBishop1 = Bishop(.white, position: CGPoint(x: Board.cellSize * Double(2), y: Board.cellSize * 7))
        board.pieces.append(whiteBishop1)
        let whiteBishop2 = Bishop(.white, position: CGPoint(x: Board.cellSize * Double(5), y: Board.cellSize * 7))
        board.pieces.append(whiteBishop2)
        
        
        let blackBishop1 = Bishop(.black, position: CGPoint(x: Board.cellSize * Double(2), y: Board.cellSize * 0))
        board.pieces.append(blackBishop1)
        let blackBishop2 = Bishop(.black, position: CGPoint(x: Board.cellSize * Double(5), y: Board.cellSize * 0))
        board.pieces.append(blackBishop2)
        
        
        let whiteQueen = Queen(.white, position: CGPoint(x: Board.cellSize * Double(3), y: Board.cellSize * 7))
        board.pieces.append(whiteQueen)
        let blackQueen = Queen(.black, position: CGPoint(x: Board.cellSize * Double(3), y: Board.cellSize * 0))
        board.pieces.append(blackQueen)
        
        
        //            let whiteKing = King(.white, position: CGPoint(x: Board.cellSize * Double(x), y: Board.cellSize))
        //            board.pieces.append(whiteKing)
        //            let blackKing = King(.white, position: CGPoint(x: Board.cellSize * Double(x), y: Board.cellSize))
        //            board.pieces.append(blackKing)
        
        updater = CADisplayLink(target: self, selector: #selector(update))
        updater.preferredFrameRateRange = CAFrameRateRange(minimum: 40, maximum: 60)
        updater.add(to: .current, forMode: .default)
        
    }
    
    
    
    @objc
    func update() {
    
    }
    
}
