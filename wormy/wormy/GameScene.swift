//
//  GameScene.swift
//  wormy
//
//  Created by Ben Finch on 4/25/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var worm: Worm!
    override func didMoveToView(view: SKView) {
        //Make a worm
        let head = HeadNode.node(CGPoint(x:self.size.width - 50, y:self.size.height / 2))
        worm = Worm(head: head, scene: self)
        for i in 1...2 {
            let prev = worm.tail()
            worm.grow(self)
        }
        
        //Food delivery
        var wait = SKAction.waitForDuration(2.5)
        var run = SKAction.runBlock {
            let food = Food.morsel(self.randomPosition())
            self.addChild(food)
        }
        
        self.runAction(SKAction.repeatActionForever(SKAction.sequence([wait, run])))
        self.physicsWorld.contactDelegate = self
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            worm.moveToLocation(location)
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            worm.moveToLocation(location)
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent)  {
    }
   
    override func update(currentTime: CFTimeInterval) {
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if (contact.bodyA.categoryBitMask == Node.collisionCategory) &&
            (contact.bodyB.categoryBitMask == Food.collisionCategory) {
                if let secondNode = contact.bodyB.node as? SKSpriteNode {
                    secondNode.removeFromParent()
                    let seg = BodyNode.node(worm.tail().tailAnchorPosition())
                    worm.grow(self)
                }
        }
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
}
