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
        
        updater = CADisplayLink(target: self, selector: #selector(update))
        updater.preferredFrameRateRange = CAFrameRateRange(minimum: 40, maximum: 60)
        updater.add(to: .current, forMode: .default)
        
    }
    
    =
    
    @objc
    func update() {
        board.pieces[0].position.y -= 1
    }
    
}
