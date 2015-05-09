//
//  BaseScene.swift
//  wormy
//
//  Created by Finch Gregory on 5/7/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import SpriteKit

class BaseScene: SKScene, SKPhysicsContactDelegate {
    var worm: HeadWorm!
    var score: Int = 0
    
    override func didMoveToView(view: SKView) {
        initialize()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            if let touchedNode = self.nodeAtPoint(location) as? BaseWorm {
                touchedNode.activate()
            }
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            worm.moveToLocation(location)
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if (contact.bodyA.categoryBitMask == Categories.head) {
            if (contact.bodyB.categoryBitMask == Categories.body) {
                if let body = contact.bodyB.node as? BaseWorm {
                    worm.consume(body)
                }
            }
        }
    }
    
    func initialize() {
        placeWorm()
        deliverFood(2)
        //startScoreKeeper()
        self.physicsWorld.contactDelegate = self
    }
    
    func placeWorm() {
        if let wormStub = self.childNodeWithName("Worm") {
            let initialPosition = wormStub.position
            wormStub.removeFromParent()
            worm = HeadWorm(position: initialPosition)
            self.addChild(worm)
            worm.consume(NeckWorm())
            worm.consume(NeckWorm())
            worm.consume(NeckWorm())
        }
    }
    
    func deliverFood(frequency : NSTimeInterval) {
        let wait = SKAction.waitForDuration(frequency)
        let run = SKAction.runBlock {
            var food = BaseWorm(textureName: Textures.simple, position: self.randomPosition())
            food.sheild(true)
            self.addChild(food)
        }
        self.runAction(SKAction.repeatActionForever(SKAction.sequence([wait, run])))
    }
    
    func randomInRange(lo: Int, hi : Int) -> Int {
        return lo + Int(arc4random_uniform(UInt32(hi - lo + 1)))
    }
    
    func randomPosition() -> CGPoint {
        // x coordinate between MinX (left) and MaxX (right):
        let randomX = randomInRange(Int(CGRectGetMinX(self.frame)), hi: Int(CGRectGetMaxX(self.frame)))
        // y coordinate between MinY (top) and MidY (middle):
        let randomY = randomInRange(Int(CGRectGetMinY(self.frame)), hi: Int(CGRectGetMaxY(self.frame)))
        return CGPoint(x: randomX, y: randomY)
    }
    
    func startScoreKeeper() {
        let wait = SKAction.waitForDuration(5)
        let incrementScore = SKAction.runBlock {
            self.score = self.score + self.fibbonaci(self.worm.lengthToEnd())
            println(self.score)
        }
        let sequence = SKAction.sequence([wait, incrementScore])
        let scoreKeeper = SKAction.repeatActionForever(sequence)
        self.runAction(scoreKeeper)
    }
    
    func fibbonaci(start : Int) -> Int {
        if (start == 0) {return 0}
        else if (start == 1) {return 1}
        else {return (fibbonaci(start-1) + fibbonaci(start-2))}
    }
}
