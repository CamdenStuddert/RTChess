import SwiftUI
import SwiftData

@main
struct RTChessApp: App {
    
    @StateObject var game = Game()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(game)
        }
    }
}
