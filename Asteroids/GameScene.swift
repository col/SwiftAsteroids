//
//  GameScene.swift
//  Asteroids
//
//  Created by Colin Harris on 5/7/15.
//  Copyright (c) 2015 Colin Harris. All rights reserved.
//

import SpriteKit

struct ArrowKeys : OptionSetType {
    let rawValue: Int
    init(rawValue: Int) { self.rawValue = rawValue }
    
    static var None : ArrowKeys { return ArrowKeys(rawValue: 0) }
    static var Up   : ArrowKeys { return ArrowKeys(rawValue: 1 << 0) }
    static var Down : ArrowKeys { return ArrowKeys(rawValue: 1 << 1) }
    static var Left : ArrowKeys { return ArrowKeys(rawValue: 1 << 2) }
    static var Right: ArrowKeys { return ArrowKeys(rawValue: 1 << 3) }
    static var Space: ArrowKeys { return ArrowKeys(rawValue: 1 << 4) }
}

class GameScene: SKScene {
    
    static let FireRate: Double = 0.17
    
    var player = Player()
    var bullets = [Bullet]()
    var lastBulletFiredAt: CFTimeInterval?
    var arrowKeys = ArrowKeys.None
    var keyDownFlag = false
    var previousFrameTime: CFTimeInterval?
    
    override func didMoveToView(view: SKView) {
        player.node.position = CGPointMake(view.frame.width/2, view.frame.height/2)
        self.addChild(player.node)
    }
    
    override func update(currentTime: CFTimeInterval) {
        let timeDelta = CGFloat(currentTime - (previousFrameTime ?? currentTime))
        
        player.update(arrowKeys, timeDelta: timeDelta)
        applyInfiniteScrollToNode(player.node, frame: self.frame)
        
        if arrowKeys.contains(.Space) && currentTime - (lastBulletFiredAt ?? 0.0) > GameScene.FireRate {
            fireBullet()
            lastBulletFiredAt = currentTime
        }
        
        for bullet in bullets {
            bullet.update(timeDelta)
            applyInfiniteScrollToNode(bullet.node, frame: self.frame)
        }
        
        previousFrameTime = currentTime
    }
    
    func fireBullet() {
        let bullet = Bullet(position: player.node.position, angle: player.rotation, velocity: player.velocity)
        self.addChild(bullet.node)
        bullets.append(bullet)
    }
    
    func applyInfiniteScrollToNode(node: SKNode, frame: CGRect) {
        if node.position.x > self.frame.width {
            node.position.x = 0
        } else if node.position.x < 0 {
            node.position.x = self.frame.width
        }
        
        if node.position.y > self.frame.height {
            node.position.y = 0
        } else if node.position.y < 0 {
            node.position.y = self.frame.height
        }
    }
    
    override func keyDown(event: NSEvent) {
        keyDownFlag = true
        interpretKeyEvents([event])
        handleKeyEvent(event, keyDown: true)
    }
    
    override func keyUp(event: NSEvent) {
        keyDownFlag = false
        interpretKeyEvents([event])
        handleKeyEvent(event, keyDown: false)
    }
    
    func handleKeyEvent(event: NSEvent, keyDown: Bool) {
        let characters = event.characters!
        for character in characters.characters {
            if character == " " {
                if keyDown {
                    arrowKeys.insert(.Space)
                } else {
                    arrowKeys.remove(.Space)
                }
            }
        }        
    }
    
//    override func insertText(insertString: AnyObject) {
//        print("InsertTest '\(insertString)'")
//        let string = insertString as! NSString
//        if string == " " {
//            fireBullet()
//        }
//    }
    
    override func moveUp(sender: AnyObject?) {
        if keyDownFlag {
            arrowKeys.insert(.Up)
        } else {
            arrowKeys.remove(.Up)
        }
    }
    
    override func moveDown(sender: AnyObject?) {
        if keyDownFlag {
            arrowKeys.insert(.Down)
        } else {
            arrowKeys.remove(.Down)
        }
    }
    
    override func moveLeft(sender: AnyObject?) {
        if keyDownFlag {
            arrowKeys.insert(.Left)
        } else {
            arrowKeys.remove(.Left)
        }
    }

    override func moveRight(sender: AnyObject?) {
        if keyDownFlag {
            arrowKeys.insert(.Right)
        } else {
            arrowKeys.remove(.Right)
        }
    }
    
}
