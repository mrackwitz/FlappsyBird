//
//  GameScene.swift
//  FlappsyBird
//
//  Created by Marius Rackwitz on 05.06.14.
//  Copyright (c) 2014 Marius Rackwitz. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    enum CollisionBitMask : UInt32 {
        case Floor = 1
    }

    enum ActionKey : String {
        case Flap = "flap"
    }
    
    let 🌈 = SKColor(red: 81.0/255.0, green: 192.0/255.0, blue: 201.0/255.0, alpha: 1.0)
    
    let groundTexture = SKTexture(imageNamed: "Land")
    let 🏢Texture     = SKTexture(imageNamed: "Sky")
    
    var 🐦 : SKNode?
    var gamePaused = false
    
    override func didMoveToView(view: SKView) {
        /* 🔧 your scene here */
        🔧Scene()
    }
    
    func 🔧Scene() {
        self.🔧🌍()
        
        // 🔧 background color
        self.backgroundColor = 🌈
        
        self.🔧Ground()
        self.🔧🏢()
        
        self.spawnBird()
    }
    
    func 🔧Ground() {
        addBackgroundSprite(groundTexture, speed: 50)
        
        let ground = SKNode()
        ground.position = CGPointMake(0, groundTexture.size().height)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width, groundTexture.size().height * 2.0))
        ground.physicsBody.dynamic = false
        ground.physicsBody.categoryBitMask = CollisionBitMask.Floor.toRaw()
        self.addChild(ground)
    }
    
    func 🔧🏢() {
        addBackgroundSprite(🏢Texture, speed: 10, offset: CGSize(width: 0, height: groundTexture.size().height * 2.0))
    }
    
    func addBackgroundSprite(texture: SKTexture, speed: CGFloat, offset: CGSize = CGSizeZero) {
        // 🔧 an action: repeatForever([move, reset])
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
    
    func 🔧🌍() {
        // Add Gravity!
        self.physicsWorld.gravity = CGVectorMake(0.0, -5.0)
        self.physicsWorld.contactDelegate = self
    }
    
    func spawnBird() {
        let birdTexture1 = SKTexture(imageNamed: "Bird-01")
        let birdTexture2 = SKTexture(imageNamed: "Bird-02")
        let birdTexture3 = SKTexture(imageNamed: "Bird-03")
        let birdTexture4 = SKTexture(imageNamed: "Bird-04")
        
        let 🐦 = SKSpriteNode(texture: birdTexture1)
        🐦.setScale(2.0)
        🐦.position = CGPoint(x: self.frame.size.width * 0.35, y:self.frame.size.height * 0.6)
        
        let animAction = SKAction.animateWithTextures([birdTexture1, birdTexture2, birdTexture3, birdTexture4], timePerFrame: 0.2)
        let flapAction = SKAction.repeatActionForever(animAction)
        🐦.runAction(flapAction, withKey: ActionKey.Flap.toRaw())
        
        🐦.physicsBody = SKPhysicsBody(circleOfRadius: 🐦.size.height / 2.0)
        🐦.physicsBody.dynamic = true
        🐦.physicsBody.contactTestBitMask = CollisionBitMask.Floor.toRaw()
        self.🐦 = 🐦
        
        self.addChild(🐦)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        if gamePaused {
            return
        }
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            🐦!.physicsBody.velocity = CGVectorMake(0, 0)
            🐦!.physicsBody.applyImpulse(CGVectorMake(0, 30))
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func didBeginContact(contact: SKPhysicsContact!) {
        /* Called when two physic objects collide */
        NSLog("didBeginContact: %@", contact)
        
        if gamePaused {
            return
        }
        
        gamePaused = true
        
        // Bird flaps no more!
        self.🐦!.removeActionForKey(ActionKey.Flap.toRaw())
    }
    
    func didEndContact(contact: SKPhysicsContact!) {
        /* Called when the contact of two physic objects ends */
        NSLog("didEndContact: %@", contact)
    }
}
