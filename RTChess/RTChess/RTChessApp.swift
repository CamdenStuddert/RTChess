import SwiftUI
import SwiftData

@main
struct RTChessApp: App {
    
    @StateObject var game = Game(team: .friend)
    
    var body: some Scene {
        WindowGroup {
//            HomeView()
            GameView()
                .environmentObject(game)
        }
    }
}
