import SwiftUI

struct GameView: View {
    
    @EnvironmentObject var game: Game
        
    var body: some View {
        
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
                        
                    case is Pawn: imageName = piece.team == .white ? "White Pawn" : "Black Pawn"
                    case is Rook: imageName = piece.team == .white ? "White Rook" : "Black Rook"
                    case is Knight: imageName = piece.team == .white ? "White Knight" : "Black Knight"
                    case is Bishop: imageName = piece.team == .white ? "White Bishop" : "Black Bishop"
                    case is Queen: imageName = piece.team == .white ? "White Queen" : "Black Queen"
                    case is King: imageName = piece.team == .white ? "White King" : "Black King"
                        
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
                    
                    if game.selected?.id == piece.id {
                        
                        context.stroke(
                            RoundedRectangle(cornerRadius: 10)
                                .path(in: CGRect(
                                    origin: CGPoint(x: piece.position.x * scale + margin, y: piece.position.y * scale + margin),
                                    size: CGSize(width: imageSize, height: imageSize))), with: .color(Color.white), style: StrokeStyle(lineWidth: 2))
                        
                        for move in piece.getAvailableMoves(board: game.board) {
                            let path = Path(CGRect(
                                x: CGFloat(move.x) * cellSize,
                                y: CGFloat(move.y) * cellSize,
                                width: cellSize,
                                height: cellSize)
                            )
                            
                            let color = Color.green.opacity(0.3)
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
        
    }
    
}

#Preview {
    GameView()
        .environmentObject(Game())
}
