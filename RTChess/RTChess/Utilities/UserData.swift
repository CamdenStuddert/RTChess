import Foundation
import SwiftData

@Model
class UserData: Identifiable {
    
    var id: String
    
    init() {
        
        self.id = UUID().uuidString
        
        struct TableMatches {
            var whiteWins: Int
            var blackWins: Int
        }
        struct MultiplayerMatches {
            var wins: Int
        }
    }
}
