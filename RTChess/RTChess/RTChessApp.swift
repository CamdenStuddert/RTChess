import SwiftUI
import SwiftData

@available(iOS 17, *)
@main
struct RTChessApp: App {
    
    @StateObject var game = Game()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
//            GameView()
                .environmentObject(game)
        }
        .modelContainer(for: UserData.self)
    }
}
