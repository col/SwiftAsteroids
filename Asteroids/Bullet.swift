//
//  Bullet.swift
//  Asteroids
//
//  Created by Colin Harris on 6/7/15.
//  Copyright © 2015 Colin Harris. All rights reserved.
//

import Foundation
import SpriteKit

class Bullet {
    
    static let Speed: CGFloat = 500.0
    static let MaxTime: CGFloat = 0.6
    
    let node: SKShapeNode
    var velocity: CGPoint
    var totalTime: CGFloat = 0.0
    
    init(position: CGPoint, angle: CGFloat, velocity: CGPoint) {
        node = SKShapeNode(circleOfRadius: 2)
        node.fillColor = NSColor.whiteColor()
        node.strokeColor = NSColor.whiteColor()
        node.position = position
        
        self.velocity = CGPointMake(
            cos(angle + CGFloat(M_PI_2)),
            sin(angle + CGFloat(M_PI_2))
        ) * Bullet.Speed
        
        // Add the velocity of the ship?
//        self.velocity = self.velocity + velocity        
    }
    
    func update(timeDelta: CGFloat) {
        totalTime += timeDelta
        if totalTime > Bullet.MaxTime {
            node.removeFromParent()
            return
        }
        
        node.position = node.position + velocity * timeDelta
    }
    
    
}