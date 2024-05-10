import Foundation
import QuartzCore

class Game: ObservableObject {
    
    static var mpRegen = 120
    static var maxMp = 15
    static var minMp = 0
    
    private var ticks = 0
    
    @Published var mp = 0
    
    @Published var board: Board
    @Published var selected: UUID? = nil
    
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
        
        
        let whiteKing = King(.white, position: CGPoint(x: Board.cellSize * Double(4), y: Board.cellSize * 7))
        board.pieces.append(whiteKing)
        let blackKing = King(.black, position: CGPoint(x: Board.cellSize * Double(4), y: Board.cellSize * 0))
        board.pieces.append(blackKing)
        
        updater = CADisplayLink(target: self, selector: #selector(update))
        updater.preferredFrameRateRange = CAFrameRateRange(minimum: 40, maximum: 60)
        updater.add(to: .current, forMode: .default)
        
    }
    
    func select(as position: CGPoint) {
                
        if let selected, let index = board.getPieceIndexWith(id: selected) {
            print(board.pieces[index])
            let location = Board.getLocation(at: position)
            if let move = board.pieces[index].getAvailableMoves(board: board).first(where: { $0.x == location.x && $0.y == location.y }) {
                switch move {
                case let .attack(x: x, y: y, id: id):
                    if let enemyIndex = board.getPieceIndexWith(id: id) {
                        board.pieces.remove(at: enemyIndex)
                    }
                    board.pieces[index].target = CGPoint(x: Double(location.x) * Board.cellSize, y: Double(location.y) * Board.cellSize)
                    self.selected = nil
                case let .available(x: x, y: y):
                    board.pieces[index].target = CGPoint(x: Double(location.x) * Board.cellSize, y: Double(location.y) * Board.cellSize)
                    self.selected = nil
                }
            }

        }
        
        for piece in board.pieces {
            if position.x > piece.position.x &&
                position.x < piece.position.x + Board.pieceSize &&
                position.y > piece.position.y &&
                position.y < piece.position.y + Board.pieceSize {
                
                selected = piece.id
                return
                
            }
        }

        
    }
    
    @objc
    func update() {
        ticks += 1
        if ticks % Self.mpRegen == 0 {
            mp = min(Self.maxMp, mp + 1)
        }
        
        for index in board.pieces.indices {
            let piece = board.pieces[index]
            
            if let target = piece.target {
                
                let delta = Vector(x: target.x - piece.position.x, y: target.y - piece.position.y)
                
                if delta.magnitude < piece.speed {
                    board.pieces[index].position = target
                    board.pieces[index].target = nil
                    
                    continue
                }
                
                let change = delta.unit * piece.speed
                
                board.pieces[index].position.x += change.x
                board.pieces[index].position.y += change.y
            }
            
        }
        
    }
    
}
