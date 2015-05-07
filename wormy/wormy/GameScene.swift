//
//  GameScene.swift
//  wormy
//
//  Created by Ben Finch on 4/25/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate, UIGestureRecognizerDelegate {
    var worm: HeadWorm!
    override func didMoveToView(view: SKView) {
        worm = HeadWorm(position: CGPoint(x:self.size.width - 50, y:self.size.height / 2))
        self.addChild(worm)
        worm.consume(NeckWorm())
        worm.consume(NeckWorm())
        worm.consume(NeckWorm())
        
        //Food delivery
        let wait = SKAction.waitForDuration(2.5)
        let run = SKAction.runBlock {
            let foodType = self.randomInRange(0, hi: 2)
            var food : BaseWorm? = nil
            switch foodType {
                case 0: food = BaseWorm(textureName: Textures.simple, position: self.randomPosition())
                case 1: food = AnchorWorm(textureName: Textures.simpleblue, position: self.randomPosition())
                case 2: food = GravityWorm(textureName: Textures.simplered, position: self.randomPosition())
            default: break
            }
            self.addChild(food!)
        }
        self.runAction(SKAction.repeatActionForever(SKAction.sequence([wait, run])))
        self.physicsWorld.contactDelegate = self
        
        self.physicsWorld.gravity = CGVectorMake(0.0, 2.5)
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
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent)  {
    }
   
    override func update(currentTime: CFTimeInterval) {
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
