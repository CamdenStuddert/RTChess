import SwiftUI

struct GameView: View {
    
    @EnvironmentObject var game: Game
        
    var body: some View {
        
        VStack {
            GeometryReader { geometry in
                let scale = geometry.size.width / CGFloat(Board.size)
                
                Canvas { context, size in

                    let cellSize = size.width / CGFloat(Board.cells)
                    
                    for y in 0..<Board.cells {
                        
                        for x in 0..<Board.cells {
                            
                            let path = Path(CGRect(
                                x: CGFloat(x) * cellSize,
                                y: CGFloat(y) * cellSize,
                                width: cellSize,
                                height: cellSize)
                            )
                            
                            let color = (y + x) % 2 == 0 ? Color.lightGrey : Color.darkGrey
                            context.fill(path, with: .color(color))
                            
                        }
                        
                    }
                    
                    for piece in game.board.pieces {
                        
                        var imageName: String? = nil
                        switch piece {
                            
                        case is Pawn: imageName = piece.team == .friend ? "White Pawn" : "Black Pawn"
                        case is Rook: imageName = piece.team == .friend ? "White Rook" : "Black Rook"
                        case is Knight: imageName = piece.team == .friend ? "White Knight" : "Black Knight"
                        case is Bishop: imageName = piece.team == .friend ? "White Bishop" : "Black Bishop"
                        case is Queen: imageName = piece.team == .friend ? "White Queen" : "Black Queen"
                        case is King: imageName = piece.team == .friend ? "White King" : "Black King"
                            
                        default: break
                        }
                        
                        let imageSize = Board.pieceSize * scale
                        let margin = (cellSize - imageSize) / 2
                        
                        context.draw(
                            Image(imageName!),
                            in: CGRect(
                                origin: CGPoint(x: piece.position.x * scale + margin, y: piece.position.y * scale + margin),
                                size: CGSize(width: imageSize, height: imageSize))
                        )
                        
                        if (piece.id == game.board.foeKingId && game.foeInCheck) || (piece.id == game.board.friendKingId && game.friendInCheck) {
                            let path = Path(CGRect(
                                x: CGFloat(piece.location.x) * cellSize,
                                y: CGFloat(piece.location.y) * cellSize,
                                width: cellSize,
                                height: cellSize)
                            )
                            context.fill(path, with: .color(Color.yellow.opacity(0.3)))
                        }
                        
                        if game.selected == piece.id {
                            
                            context.stroke(
                                RoundedRectangle(cornerRadius: 10)
                                    .path(in: CGRect(
                                        origin: CGPoint(x: piece.position.x * scale + margin, y: piece.position.y * scale + margin),
                                        size: CGSize(width: imageSize, height: imageSize))), with: .color(Color.white), style: StrokeStyle(lineWidth: 2))
                            
                            for move in piece.getAvailableMoves(board: game.board) {
                                let expensive = game.mp < piece.cost(to: move.location)
                                let path = Path(CGRect(
                                    x: CGFloat(move.x) * cellSize,
                                    y: CGFloat(move.y) * cellSize,
                                    width: cellSize,
                                    height: cellSize)
                                )
                                
                                var color: Color
                                switch move {
                                    case .attack: color = Color.red.opacity(0.3)
                                    case .available: color = Color.green.opacity(0.3)
                                }
                                color = expensive ? Color.blue.opacity(0.3) : color
                                
                                context.fill(path, with: .color(color))

                            }
                            
                        }
                        
                    }
                    
                }
                .background(Color.white)
                .onTapGesture { location in
                    game.select(as: CGPoint(x: location.x / scale, y: location.y / scale))
                }
            }
            .padding()
            
            HStack(spacing: 0) {
                ForEach(Game.minMp..<Game.maxMp, id: \.self) { index in
                    if(game.mp >= index) {
                        Color.red
                            .border(Color.black, width: 1)
                    } else {
                        Color.gray
                            .border(Color.black, width: 1)
                    }
                }
            }
            .frame(height: 40)
            .padding()
            .padding(.bottom, 16)
        }
        
    }
    
}

#Preview {
    GameView()
        .environmentObject(Game())
}
