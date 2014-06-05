//
//  GameScene.swift
//  FlappsyBird
//
//  Created by Marius Rackwitz on 05.06.14.
//  Copyright (c) 2014 Marius Rackwitz. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let skyColor = SKColor(red: 81.0/255.0, green: 192.0/255.0, blue: 201.0/255.0, alpha: 1.0)
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        setupScene()
    }
    
    func setupScene() {
        // Setup background color
        self.backgroundColor = skyColor
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
