import Foundation
import QuartzCore

class Game: ObservableObject {
    
    static var mpRegen = 120
    static var maxMp = 15
    static var minMp = 0
    
    private var ticks = 0
    
    @Published var mp = Build.dev ? 1500 : 5
    @Published var board: Board
    @Published var selected: UUID? = nil
    
    var updater: CADisplayLink = CADisplayLink()
    var team: Team
    
    var friendInCheck: Bool {
        !board.friendChallangers.isEmpty
    }
    var foeInCheck: Bool {
        !board.foeChallangers.isEmpty
    }

    init(team: Team) {
        self.team = team
        board = Board()
                    
        updater = CADisplayLink(target: self, selector: #selector(update))
        updater.preferredFrameRateRange = CAFrameRateRange(minimum: 40, maximum: 60)
        updater.add(to: .current, forMode: .default)
        
        
    }
    
    func select(as position: CGPoint) {
                
        if let selected, let index = board.getPieceIndexWith(id: selected) {
            let tappedLocation = Board.getLocation(at: position)
            

            let cost = board.pieces[index].cost(to: tappedLocation)
            if let move = board.pieces[index].getAvailableMoves(board: board).first(where: { $0.x == tappedLocation.x && $0.y == tappedLocation.y }) {
                if cost <= mp {
                    switch move {
                    case let .attack(x: _, y: _, piece: piece):
                        board.pieces[index].target = CGPoint(x: Double(tappedLocation.x) * Board.cellSize, y: Double(tappedLocation.y) * Board.cellSize)
//                        if let enemyIndex = board.getPieceIndexWith(id: piece.id) {
//                            board.pieces.remove(at: enemyIndex)
//                        }
                    case .available(x: _, y: _):
                        board.pieces[index].target = CGPoint(x: Double(tappedLocation.x) * Board.cellSize, y: Double(tappedLocation.y) * Board.cellSize)
                    }
                    
                    self.selected = nil
                    mp -= cost
                }
            }

        }
        
        var clickedPiece = false
        for piece in board.pieces {
            if position.x > piece.position.x &&
                position.x < piece.position.x + Board.pieceSize &&
                position.y > piece.position.y &&
                position.y < piece.position.y + Board.pieceSize {
                
                if piece.team == team {
                    selected = piece.id
                    clickedPiece = true
                }
                return
                
            }
        }
        
        if !clickedPiece {
            selected = nil
        }
        
    }
    
    @objc
    func update() {
        ticks += 1
        if ticks % Self.mpRegen == 0 && !Build.dev {
            mp = min(Self.maxMp, mp + 1)
        }
        
        var delete: Int? = nil

        for index in board.pieces.indices {
            let piece = board.pieces[index]
            
            if let target = piece.target {
                
                let delta = Vector(x: target.x - piece.position.x, y: target.y - piece.position.y)
                
                if delta.magnitude < piece.speed {
                    let piecesAtLocation = board.getPiecesAt(location: Board.getLocation(at: target))
                    for pieceAtLocation in piecesAtLocation {
                        if(pieceAtLocation.team != piece.team) {
                            delete = board.getPieceIndexWith(id: pieceAtLocation.id)
                        }
                    }
//                    if let enemyIndex = board.getPieceIndexAt(location: Board.getLocation(at: target)) {
//                        delete = enemyIndex
//                    }
                    
                    board.pieces[index].position = target
                    board.pieces[index].target = nil
                    //                    if let enemyIndex = board.getPieceIndexWith(id: piece.id) {
//                        board.pieces.remove(at: enemyIndex)
//                    }
                    
                    continue
                }
                
                let change = delta.unit * piece.speed
                
                board.pieces[index].position.x += change.x
                board.pieces[index].position.y += change.y
            }
            
        }
        
        if let delete {
            board.pieces.remove(at: delete)
        }
        
        var friendChallangers:[Piece] = []
        var foeChallangers:[Piece] = []
        for piece in board.pieces {
            if piece.target != nil { continue }
            let moves = piece.getAvailableMoves(board: board)
            
            for move in moves {
                if case .attack(_, _, let enemy) = move {
                    if enemy.id == board.foeKingId && piece.team == .friend {
                        foeChallangers.append(piece)
                    }
                    if enemy.id == board.friendKingId && piece.team == .foe {
                        friendChallangers.append(piece)
                    }
                }
            }
        }
        
        board.friendChallangers = friendChallangers
        board.foeChallangers = foeChallangers
    }

}
