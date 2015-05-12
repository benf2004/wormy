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
                if let head = contact.bodyA.node as? HeadWorm {
                    if let segment = contact.bodyB.node as? BaseWorm {
                        if (segment.headless()) {
                            head.consume(segment)
                        } else {
                            segment.activate()
                        }
                    }
                }
            } else if (contact.bodyB.categoryBitMask == Categories.head) {
                if let head = contact.bodyA.node as? HeadWorm {
                    if let otherHead = contact.bodyB.node as? HeadWorm {
//                        head.killNeighborsAndDie(head.lengthToEnd())
//                        otherHead.killNeighborsAndDie(otherHead.lengthToEnd())
                    }
                }
            }
        }
    }
    
    func initialize() {
        placeWorm()
        placeObstacles()
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
