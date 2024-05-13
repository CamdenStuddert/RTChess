import Foundation

struct Board {
    static var pieceScale = 0.8
    static let cells: Int = 8
    static let size: Double = 1000
    static var cellSize: Double {
        Board.size / Double(Board.cells)
    }
    static var pieceSize: Double {
        cellSize * pieceScale
    }
    
    static func getLocation(at position: CGPoint) -> (x: Int, y: Int) {
        (x: Int(floor(position.x / Board.cellSize)), y: Int(floor(position.y / Board.cellSize)))
    }
    
    var pieces: [Piece] = []
    var friendPieces: [Piece] {
        pieces.filter({$0.team == .friend})
    }
    var foePieces: [Piece] {
        pieces.filter({$0.team == .foe})
    }
    var friendKingId: UUID
    var foeKingId: UUID
    var friendChallangers: [Piece] = []    
    var foeChallangers: [Piece] = []

    init() {
        for x in 0..<Board.cells {
            let whitePawn = Pawn(.friend, position: CGPoint(x: Board.cellSize * Double(x), y: Board.cellSize * 6))
            pieces.append(whitePawn)
            let blackPawn = Pawn(.foe, position: CGPoint(x: Board.cellSize * Double(x), y: Board.cellSize))
            pieces.append(blackPawn)
        }
        
        //The Doubles are to position the pieces on an 8x8 Grid
        
        let whiteRook1 = Rook(.friend, position: CGPoint(x: Board.cellSize * Double(0), y: Board.cellSize * 7))
        pieces.append(whiteRook1)
        let whiteRook2 = Rook(.friend, position: CGPoint(x: Board.cellSize * Double(7), y: Board.cellSize * 7))
        pieces.append(whiteRook2)
        
        
        let blackRook1 = Rook(.foe, position: CGPoint(x: Board.cellSize * Double(0), y: Board.cellSize * 0))
        pieces.append(blackRook1)
        let blackRook2 = Rook(.foe, position: CGPoint(x: Board.cellSize * Double(7), y: Board.cellSize * 0))
        pieces.append(blackRook2)
        
        
        let whiteKnight1 = Knight(.friend, position: CGPoint(x: Board.cellSize * Double(1), y: Board.cellSize * 7))
        pieces.append(whiteKnight1)
        let whiteKnight2 = Knight(.friend, position: CGPoint(x: Board.cellSize * Double(6), y: Board.cellSize * 7))
        pieces.append(whiteKnight2)
        
        
        let blackKnight1 = Knight(.foe, position: CGPoint(x: Board.cellSize * Double(1), y: Board.cellSize * 0))
        pieces.append(blackKnight1)
        let blackKnight2 = Knight(.foe, position: CGPoint(x: Board.cellSize * Double(6), y: Board.cellSize * 0))
        pieces.append(blackKnight2)
        
        
        let whiteBishop1 = Bishop(.friend, position: CGPoint(x: Board.cellSize * Double(2), y: Board.cellSize * 7))
        pieces.append(whiteBishop1)
        let whiteBishop2 = Bishop(.friend, position: CGPoint(x: Board.cellSize * Double(5), y: Board.cellSize * 7))
        pieces.append(whiteBishop2)
        
        
        let blackBishop1 = Bishop(.foe, position: CGPoint(x: Board.cellSize * Double(2), y: Board.cellSize * 0))
        pieces.append(blackBishop1)
        let blackBishop2 = Bishop(.foe, position: CGPoint(x: Board.cellSize * Double(5), y: Board.cellSize * 0))
        pieces.append(blackBishop2)
        
        
        let whiteQueen = Queen(.friend, position: CGPoint(x: Board.cellSize * Double(3), y: Board.cellSize * 7))
        pieces.append(whiteQueen)
        let blackQueen = Queen(.foe, position: CGPoint(x: Board.cellSize * Double(3), y: Board.cellSize * 0))
        pieces.append(blackQueen)
        
        
        let whiteKing = King(.friend, position: CGPoint(x: Board.cellSize * Double(4), y: Board.cellSize * 7))
        pieces.append(whiteKing)
        friendKingId = whiteKing.id
        let blackKing = King(.foe, position: CGPoint(x: Board.cellSize * Double(4), y: Board.cellSize * 0))
        pieces.append(blackKing)
        foeKingId = blackKing.id

    }
    
    func getPieceWith(id: UUID) -> Piece? {
        guard let index = getPieceIndexWith(id: id) else {
            return nil
        }
        return pieces[index]
    
    }
    func getPieceIndexWith(id: UUID) -> Int? {
        guard let index = pieces.firstIndex(where: { $0.id == id}) else {
            return nil
        }
        return index
    
    }

    func getPieceIndexAt(position: CGPoint) -> Int? {
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
    
    func getPieceIndexAt(location: (x: Int, y: Int)) -> Int? {
        for index in pieces.indices {
            let pieceLocation = pieces[index].location
            
            if(location == pieceLocation) {
                return index
            }
        }
        
        return nil
    }
    
    func getPiecesAt(location: (x: Int, y: Int)) -> [Piece] {
        var selectedPieces: [Piece] = []
        
        for index in pieces.indices {
            let pieceLocation = pieces[index].location
            
            if(location == pieceLocation) {
                selectedPieces.append(pieces[index])
            }
        }
        
        return selectedPieces
    }


}

