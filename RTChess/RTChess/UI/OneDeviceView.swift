import SwiftUI
import SwiftData

struct OneDeviceView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var modelContext
            
    @StateObject var game = Game()
    @Query var query: [UserData]

    private var winnerBinding: Binding<Bool> {
        Binding {
            game.winner != nil
        } set: { value in
            if !value {
                game.winner = nil
            }
        }
    }
    private var winMessage: String {
        return game.winner == .friend ? "White Wins!" : "Black Wins!"
    }

    var body: some View {
        GeometryReader { geo in
            
            Image("Background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            
            VStack {
                HStack(spacing: 0) {
                    ForEach(Game.minMp..<Game.maxMp, id: \.self) { index in
                        if(game.blackMp >= index) {
                            Color.power
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
                            
                            if game.whiteSelected == piece.id || game.blackSelected == piece.id {
                                
                                context.stroke(
                                    RoundedRectangle(cornerRadius: 10)
                                        .path(in: CGRect(
                                            origin: CGPoint(x: piece.position.x * scale + margin, y: piece.position.y * scale + margin),
                                            size: CGSize(width: imageSize, height: imageSize))), with: .color(Color.white), style: StrokeStyle(lineWidth: 2))
                                
                                for move in piece.getAvailableMoves(board: game.board) {
                                    let expensive = piece.team == .friend ?
                                    game.whiteMp < piece.cost(to: move.location) :
                                    game.blackMp < piece.cost(to: move.location)
                                    
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
                .aspectRatio(1, contentMode: .fit)
                .padding(10)
                .border(Color.brown, width: 10)
                .padding()
                
                HStack(spacing: 0) {
                    ForEach(Game.minMp..<Game.maxMp, id: \.self) { index in
                        if(game.whiteMp >= index) {
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
        .alert(winMessage, isPresented: winnerBinding) {
            Button("REPLAY", role: .cancel) {

                let userData = query.isEmpty ? UserData() : query[0]
                if(game.winner == .friend) {
                    userData.tableMatches.whiteWins += 1
                } else {
                    userData.tableMatches.blackWins += 1
                }
                modelContext.insert(userData)
                try! modelContext.save()

                game.restart()
            }
            Button("Back to Menu") {
                let userData = query.isEmpty ? UserData() : query[0]
                if(game.winner == .friend) {
                    userData.tableMatches.whiteWins += 1
                } else {
                    userData.tableMatches.blackWins += 1
                }
                modelContext.insert(userData)
                try! modelContext.save()
            action: do {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

#Preview {
    OneDeviceView()
        .environmentObject(Game())
}
