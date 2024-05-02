//
//  Vector.swift
//  RTChess
//
//  Created by Corbin Bigler on 5/1/24.
//

import Foundation

struct Vector {
    
    var x: CGFloat
    var y: CGFloat
    
    var magnitude: CGFloat { sqrt((x*x) + (y*y)) }
    var unit: Vector { self / magnitude }
    
    static func * (left: Vector, right: CGFloat) -> Vector {
        return Vector(x: left.x * right, y: left.y * right)
    }
    static func / (left: Vector, right: CGFloat) -> Vector {
        return Vector(x: left.x / right, y: left.y / right)
    }

}
