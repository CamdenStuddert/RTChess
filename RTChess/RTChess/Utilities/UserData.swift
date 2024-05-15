import Foundation
import SwiftData

@Model
final class UserData: Identifiable {
    
    var id: String
    var tableMatches: TableMatches
    var multiplayerMatches: MultiplayerMatches

    init() {
        
        self.id = UUID().uuidString
        self.tableMatches = TableMatches(whiteWins: 0, blackWins: 0)
        self.multiplayerMatches = MultiplayerMatches(wins: 0)
        
    }
    
    struct TableMatches: Codable {
        var whiteWins: Int
        var blackWins: Int
    }
    struct MultiplayerMatches: Codable {
        var wins: Int
    }

    
}
