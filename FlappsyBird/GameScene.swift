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
    
    let groundTexture = SKTexture(imageNamed: "Land")
    let skyTexture    = SKTexture(imageNamed: "Sky")
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        setupScene()
    }
    
    func setupScene() {
        // Setup background color
        self.backgroundColor = skyColor
        
        self.setupGround()
        self.setupSkyline()
        
        self.spawnBird()
    }
    
    func setupGround() {
        addBackgroundSprite(groundTexture)
    }
    
    func setupSkyline() {
        addBackgroundSprite(skyTexture, offset: CGSize(width: 0, height: groundTexture.size().height * 2.0))
    }
    
    func addBackgroundSprite(texture: SKTexture, offset: CGSize = CGSizeZero) {
        for var i:CGFloat = 0; i < self.frame.size.width / texture.size().width; ++i {
            let sprite = SKSpriteNode(texture: texture)
            sprite.setScale(2.0)
            sprite.position = CGPointMake(i * sprite.size.width + offset.width, sprite.size.height / 2.0 + offset.height)
            self.addChild(sprite)
        }
    }
    
    func spawnBird() {
        let birdTexture1 = SKTexture(imageNamed: "Bird-01")
        
        let bird = SKSpriteNode(texture: birdTexture1)
        bird.setScale(2.0)
        bird.position = CGPoint(x: self.frame.size.width * 0.35, y:self.frame.size.height * 0.6)
        
        self.addChild(bird)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
