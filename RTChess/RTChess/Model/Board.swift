import Foundation

struct Board {
    var pieces: [[Piece?]] = [
        [nil,nil,nil,nil,nil,nil,nil,nil],
        [Pawn(team: .black),Pawn(team: .black),Pawn(team: .black),Pawn(team: .black),Pawn(team: .black),Pawn(team: .black),Pawn(team: .black),Pawn(team: .black)],
        [nil,nil,nil,nil,nil,nil,nil,nil],
        [nil,nil,nil,nil,nil,nil,nil,nil],
        [nil,nil,nil,nil,nil,nil,nil,nil],
        [nil,nil,nil,nil,nil,nil,nil,nil],
        [Pawn(team: .white),Pawn(team: .white),Pawn(team: .white),Pawn(team: .white),Pawn(team: .white),Pawn(team: .white),Pawn(team: .white),Pawn(team: .white)],
        [nil,nil,nil,nil,nil,nil,nil,nil],
    ]
    
    
}
