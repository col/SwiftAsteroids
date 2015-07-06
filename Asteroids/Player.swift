//
//  Player.swift
//  Asteroids
//
//  Created by Colin Harris on 5/7/15.
//  Copyright © 2015 Colin Harris. All rights reserved.
//

import Foundation
import SpriteKit

class Player {
    
    static let RotationSpeed: CGFloat = 5.0
    static let MaxAcceleration: CGFloat = 10.0
    static let Deceleration: CGFloat = 0.995
    static let MaxSpeed: CGFloat = 300.0
    
    let node: SKSpriteNode

    var rotation: CGFloat = 0.0
    var acceleration = CGPointMake(0,0)
    var velocity = CGPointMake(0,0)
    
    init() {
        node = SKSpriteNode(imageNamed: "Player")
        node.anchorPoint = CGPointMake(0.5, 0.3)
    }
    
    func update(arrowKeys: ArrowKeys, timeDelta: CGFloat) {
        if arrowKeys.contains(.Right) {
            rotation = rotation - timeDelta * Player.RotationSpeed
        } else if arrowKeys.contains(.Left) {
            rotation = rotation + timeDelta * Player.RotationSpeed
        }
    
        if arrowKeys.contains(.Up) {
            accelerate()
        } else {
            stop()
        }
        
        updateVelocity()
        
        updatePosition(timeDelta)
    }
    
    func accelerate() {
        acceleration = acceleration + CGPointMake(
            cos(node.zRotation + CGFloat(M_PI_2)),
            sin(node.zRotation + CGFloat(M_PI_2))
        )
        if acceleration.length > Player.MaxAcceleration {
            acceleration = acceleration * (Player.MaxAcceleration / acceleration.length)
        }
    }
    
    func stop() {
        acceleration = CGPointMake(0,0)
    }
    
    func updateVelocity() {
        if acceleration.length > 0 {
            velocity = velocity + acceleration
        } else {
            velocity = velocity * Player.Deceleration
        }
        
        if velocity.length > Player.MaxSpeed {
            velocity = velocity * (Player.MaxSpeed / velocity.length)
        }
    }
    
    func updatePosition(timeDelta: CGFloat) {
        node.zRotation = rotation
        node.position = node.position + velocity * timeDelta
    }
    
}