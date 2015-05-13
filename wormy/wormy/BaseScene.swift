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
        var head1 : HeadWorm? = nil
        var head2 : HeadWorm? = nil
        var segment : BaseWorm? = nil
        
        if (contact.bodyA.categoryBitMask == Categories.head &&
            contact.bodyB.categoryBitMask == Categories.body) {
                head1 = contact.bodyA.node as? HeadWorm
                segment = contact.bodyB.node as? BaseWorm
        } else if (contact.bodyA.categoryBitMask == Categories.body &&
            contact.bodyB.categoryBitMask == Categories.head) {
                head1 = contact.bodyB.node as? HeadWorm
                segment = contact.bodyA.node as? BaseWorm
        } else if (contact.bodyA.categoryBitMask == Categories.head &&
            contact.bodyB.categoryBitMask == Categories.head) {
                head1 = contact.bodyA.node as? HeadWorm
                head2 = contact.bodyB.node as? HeadWorm
        }
        
        if let food = segment {
            if (food.headless()) {
                head1?.consume(food)
            } else {
                food.activate()
            }
        }
        
        if let murderer = head2 {
//            head1?.killNeighborsAndDie(head1!.lengthToEnd())
//            murderer.killNeighborsAndDie(murderer.lengthToEnd())
        }
    }
    
    func initialize() {
        placeWorm()
        placeObstacles()
        deliverFood(2)
        //startScoreKeeper()
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 4.9)
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
    
    func placeObstacles() {
        
    }
    
    func deliverFood(frequency : NSTimeInterval) {
        let wait = SKAction.waitForDuration(frequency)
        let run = SKAction.runBlock {
            var food = BaseWorm(textureName: Textures.simple, position: Game.randomPosition(self.frame))
            food.shield(true)
            self.addChild(food)
        }
        self.runAction(SKAction.repeatActionForever(SKAction.sequence([wait, run])))
    }
    
    func startScoreKeeper() {
        let wait = SKAction.waitForDuration(5)
        let incrementScore = SKAction.runBlock {
            self.score = self.score + Game.fibbonaci(self.worm.lengthToEnd())
            //Ben ... set the label value to the score here.
        }
        let sequence = SKAction.sequence([wait, incrementScore])
        let scoreKeeper = SKAction.repeatActionForever(sequence)
        self.runAction(scoreKeeper)
    }
}
