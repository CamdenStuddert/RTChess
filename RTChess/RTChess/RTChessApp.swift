import SwiftUI
import SwiftData

@available(iOS 17, *)
@main
struct RTChessApp: App {
        
    var body: some Scene {
        WindowGroup {
            HomeView()
//                .environmentObject(game)
        }
        .modelContainer(for: UserData.self)
    }
}
