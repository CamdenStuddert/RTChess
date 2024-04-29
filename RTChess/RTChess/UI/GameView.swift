import SwiftUI

struct GameView: View {
    static var pieceScale = 0.8
    
    @EnvironmentObject var game: Game
    
    var body: some View {
        
        Canvas { context, size in
                        
            let cellSize = size.width / CGFloat(Board.cells)
            let scale = size.width / CGFloat(Board.size)
            
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
                
                let imageSize = cellSize * Self.pieceScale
                let margin = (cellSize - imageSize) / 2
                
                context.draw(Image(imageName!), in: CGRect(
                    origin: CGPoint(x: piece.position.x * scale + margin, y: piece.position.y * scale + margin),
                    size: CGSize(width: imageSize, height: imageSize))
                )
            }
            
        }
        .padding()
        .background(Color.white)
        .onTapGesture { location in
        }
        
    }
    
}

#Preview {
    GameView()
        .environmentObject(Game())
}
