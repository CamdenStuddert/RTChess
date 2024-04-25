import SwiftUI

struct ContentView: View {
    
//    let cellSize: CGFloat = 40
    
    @EnvironmentObject var game: Game
    
    var body: some View {
        Canvas { context, size in
            
            let cellSize: CGFloat = 40
            
            for y in 0..<Game.boardSize {
                for x in 0..<Game.boardSize {

                    let path = Path(CGRect(
                        x: CGFloat(x) * cellSize,
                        y: CGFloat(y) * cellSize,
                        width: cellSize,
                        height: cellSize)
                    )
                
                    let color = (y + x) % 2 == 0 ? Color.white : Color.black
                    context.fill(path, with: .color(color))
                    
                    if y == 6 {
                            context.draw(Image("White Pawn"), in: CGRect(
                                x: CGFloat(x) * cellSize,
                                y: CGFloat(y) * cellSize,
                                width: cellSize,
                                height: cellSize))
                    }
                    
                }
                
            }
        }
        .background(Color.gray)
        .onTapGesture { location in
            print(location)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Game())
}
