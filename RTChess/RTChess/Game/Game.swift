import Foundation
import QuartzCore

class Game: ObservableObject {
    
    static var mpRegen = 120
    static var maxMp = 15
    static var minMp = 0
    
    private var ticks = 0
    
    @Published var whiteMp = Build.dev ? 1500 : 5
    @Published var blackMp = Build.dev ? 1500 : 5
    @Published var board: Board
    @Published var whiteSelected: UUID? = nil
    @Published var blackSelected: UUID? = nil
    @Published var winner: Team? = nil

    var updater: CADisplayLink = CADisplayLink()
    
    var friendInCheck: Bool {
        !board.friendChallangers.isEmpty
    }
    var foeInCheck: Bool {
        !board.foeChallangers.isEmpty
    }

    init() {
        
        board = Board()
                    
        updater = CADisplayLink(target: self, selector: #selector(update))
        updater.preferredFrameRateRange = CAFrameRateRange(minimum: 40, maximum: 60)
        updater.add(to: .current, forMode: .default)
        
        
    }
    
    func select(as position: CGPoint) {
                
        if let whiteSelected, let index = board.getPieceIndexWith(id: whiteSelected) {
            let tappedLocation = Board.getLocation(at: position)
            

            let cost = board.pieces[index].cost(to: tappedLocation)
            if let move = board.pieces[index].getAvailableMoves(board: board).first(where: { $0.x == tappedLocation.x && $0.y == tappedLocation.y }) {
                if (board.pieces[index].team == .friend && whiteMp >= cost) ||
                    (board.pieces[index].team == .foe && blackMp >= cost){
                    switch move {
                    case let .attack(x: _, y: _, piece: piece):
                        board.pieces[index].target = CGPoint(x: Double(tappedLocation.x) * Board.cellSize, y: Double(tappedLocation.y) * Board.cellSize)
                    case .available(x: _, y: _):
                        board.pieces[index].target = CGPoint(x: Double(tappedLocation.x) * Board.cellSize, y: Double(tappedLocation.y) * Board.cellSize)
                    }
                    
                    self.whiteSelected = nil
                    if board.pieces[index].team == .friend {
                        whiteMp -= cost
                    } else {
                        blackMp -= cost
                    }
                }
            }
        }
        
        if let blackSelected, let index = board.getPieceIndexWith(id: blackSelected) {
            let tappedLocation = Board.getLocation(at: position)
            

            let cost = board.pieces[index].cost(to: tappedLocation)
            if let move = board.pieces[index].getAvailableMoves(board: board).first(where: { $0.x == tappedLocation.x && $0.y == tappedLocation.y }) {
                if (board.pieces[index].team == .foe && blackMp >= cost){
                    switch move {
                    case let .attack(x: _, y: _, piece: piece):
                        board.pieces[index].target = CGPoint(x: Double(tappedLocation.x) * Board.cellSize, y: Double(tappedLocation.y) * Board.cellSize)
                    case .available(x: _, y: _):
                        board.pieces[index].target = CGPoint(x: Double(tappedLocation.x) * Board.cellSize, y: Double(tappedLocation.y) * Board.cellSize)
                    }
                    
                    self.blackSelected = nil
                        blackMp -= cost
                }
            }
        }
        
        for piece in board.pieces {
            if position.x > piece.position.x &&
                position.x < piece.position.x + Board.pieceSize &&
                position.y > piece.position.y &&
                position.y < piece.position.y + Board.pieceSize {
                
                if piece.team == .friend {
                    whiteSelected = piece.id
                } else {
                    blackSelected = piece.id
                }
                
                return
                
            }
        }
        
    }
    
    func restart() {
        let model = Game()
        ticks = 0
        
        whiteMp = model.whiteMp
        blackMp = model.blackMp
        board = model.board
        whiteSelected = model.whiteSelected
        blackSelected = model.blackSelected
        winner = model.winner
    }
    
    @objc
    func update() {
        ticks += 1
        if ticks % Self.mpRegen == 0 && !Build.dev {
            whiteMp = min(Self.maxMp, whiteMp + 1)
            blackMp = min(Self.maxMp, blackMp + 1)
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
                    
                    board.pieces[index].position = target
                    board.pieces[index].target = nil
                    
                    continue
                }
                
                let change = delta.unit * piece.speed
                
                board.pieces[index].position.x += change.x
                board.pieces[index].position.y += change.y
            }
            
        }
        
        if let delete {
            if board.foeKingId == board.pieces[delete].id {
//                print("White Wins!")
                winner = Team.friend
            } else if board.friendKingId == board.pieces[delete].id {
//                print("Black Wins!")
                winner = Team.foe
            }
            board.pieces.remove(at: delete)
        }
    }

}
