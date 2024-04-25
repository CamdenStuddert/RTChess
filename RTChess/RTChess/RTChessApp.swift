import SwiftUI
import SwiftData

@main
struct RTChessApp: App {
    
    @StateObject var game = Game()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(game)
        }
    }
}
