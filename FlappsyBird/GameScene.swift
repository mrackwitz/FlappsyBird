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
        self.setupPhysicsWorld()
        
        // Setup background color
        self.backgroundColor = skyColor
        
        self.setupGround()
        self.setupSkyline()
        
        self.spawnBird()
    }
    
    func setupGround() {
        addBackgroundSprite(groundTexture, speed: 50)
    }
    
    func setupSkyline() {
        addBackgroundSprite(skyTexture, speed: 10, offset: CGSize(width: 0, height: groundTexture.size().height * 2.0))
    }
    
    func addBackgroundSprite(texture: SKTexture, speed: CGFloat, offset: CGSize = CGSizeZero) {
        // Setup an action: repeatForever([move, reset])
        let moveSpriteAction = SKAction.moveByX(-texture.size().width * 2.0, y: 0, duration: NSTimeInterval((1.0 / speed) * texture.size().width * 2.0))
        let resetSpriteAction = SKAction.moveByX(texture.size().width * 2.0, y: 0, duration: 0.0)
        let moveSpritesForeverAction = SKAction.repeatActionForever(SKAction.sequence([moveSpriteAction, resetSpriteAction]))
        
        for var i:CGFloat = 0; i < 2.0 + self.frame.size.width / (texture.size().width * 2.0); ++i {
            let sprite = SKSpriteNode(texture: texture)
            sprite.setScale(2.0)
            sprite.position = CGPointMake(i * sprite.size.width + offset.width, sprite.size.height / 2.0 + offset.height)
            sprite.runAction(moveSpritesForeverAction)
            self.addChild(sprite)
        }
    }
    
    func setupPhysicsWorld() {
        // Add Gravity!
        self.physicsWorld.gravity = CGVectorMake(0.0, -5.0)
    }
    
    func spawnBird() {
        let birdTexture1 = SKTexture(imageNamed: "Bird-01")
        let birdTexture2 = SKTexture(imageNamed: "Bird-02")
        let birdTexture3 = SKTexture(imageNamed: "Bird-03")
        let birdTexture4 = SKTexture(imageNamed: "Bird-04")
        
        let bird = SKSpriteNode(texture: birdTexture1)
        bird.setScale(2.0)
        bird.position = CGPoint(x: self.frame.size.width * 0.35, y:self.frame.size.height * 0.6)
        
        let animAction = SKAction.animateWithTextures([birdTexture1, birdTexture2, birdTexture3, birdTexture4], timePerFrame: 0.2)
        let flapAction = SKAction.repeatActionForever(animAction)
        bird.runAction(flapAction)
        
        self.addChild(bird)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
