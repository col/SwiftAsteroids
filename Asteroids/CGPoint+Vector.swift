//
//  CGPoint+Vector.swift
//  Asteroids
//
//  Created by Colin Harris on 6/7/15.
//  Copyright © 2015 Colin Harris. All rights reserved.
//

import Foundation

// Vector addition
public func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

// Vector subtraction
public func -(left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

// Vector * scalar
public func *(point: CGPoint, factor: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * factor, y:point.y * factor)
}

public extension CGPoint {
    // Get the length (a.k.a. magnitude) of the vector
    var length: CGFloat { return sqrt(self.x * self.x + self.y * self.y) }
    
    // Normalize the vector (preserve its direction, but change its magnitude to 1)
    var normalized: CGPoint { return CGPoint(x: self.x / self.length, y: self.y / self.length) }
}