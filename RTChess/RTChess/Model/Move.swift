//
//  Move.swift
//  RTChess
//
//  Created by Corbin Bigler on 5/6/24.
//

import Foundation

private protocol MoveProtocol {
    var x: Int {get}
    var y: Int {get}
}

enum Move: MoveProtocol {
    var x: Int {
        switch self {
        case let .available(x, y): return x
        case let .attack(x, y): return x
        }
    }
    var y: Int {
        switch self {
        case let .available(x, y): return y
        case let .attack(x, y): return y
        }
    }
     
    case available(x: Int, y: Int)
    case attack(x: Int, y: Int)
}
//struct Move {
//    let x: Int
//    let y: Int
//    let variant: Variant
//    
//    enum Variant {
//        case available
//        case attack
//    }
//}
