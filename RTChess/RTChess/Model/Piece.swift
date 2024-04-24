//
//  Piece.swift
//  RTChess
//
//  Created by Corbin Bigler on 4/23/24.
//

import Foundation

protocol Piece {
    var team: Team { get }
    
    func getAvailableMoves(board: Board, from position: (x: Int, y: Int))
}

struct Knight: Piece {
    var team: Team
    
    func getAvailableMoves(board: Board, from position: (x: Int, y: Int)) {
        
    }
    
}

struct Pawn: Piece {
    var team: Team
    
    func getAvailableMoves(board: Board, from position: (x: Int, y: Int)) {
        
    }
    
}
