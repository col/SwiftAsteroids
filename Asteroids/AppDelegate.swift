//
//  AppDelegate.swift
//  Asteroids
//
//  Created by Colin Harris on 5/7/15.
//  Copyright (c) 2015 Colin Harris. All rights reserved.
//


import Cocoa
import SpriteKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var skView: SKView!
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        /* Pick a size for the scene */
        let scene = GameScene(size: skView.bounds.size)
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill
        
        self.skView!.presentScene(scene)
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        self.skView!.ignoresSiblingOrder = true
        
        self.skView!.showsFPS = true
        self.skView!.showsNodeCount = true

    }
    
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true
    }
}
