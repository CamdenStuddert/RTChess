import Foundation

struct GameData: Codable {
    
    var team: String
    var pieces: [PieceData]
    
    struct PieceData: Codable {
        var position: PointData
        var target: PointData?
        var team: String
    }
    
    struct PointData: Codable {
        var x: Float
        var y: Float
    }
    
}
