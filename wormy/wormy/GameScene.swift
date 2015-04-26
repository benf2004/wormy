//
//  GameScene.swift
//  wormy
//
//  Created by Ben Finch on 4/25/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var head: HeadNode!
    var tail: HeadNode!
    var target: CGPoint = CGPoint()
    var touching = false
    override func didMoveToView(view: SKView) {
        head = HeadNode.head(CGPoint(x:self.size.width / 4, y:self.size.height / 2))
        self.addChild(head)
        
        tail = HeadNode.head(CGPoint(x:head.position.x-head.size.width, y:head.position.y))
        self.addChild(tail)
        head.joinToOther(tail, physicsWorld: self.physicsWorld)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            if head.frame.contains(location) {
                target = location
                touching = true
            }
        }
//        for touch: AnyObject in touches {
//            let sprite = HeadNode.head(touch.locationInNode(self))
//            self.addChild(sprite)
//        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            target = location
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent)  {
        touching = false
    }
   
    override func update(currentTime: CFTimeInterval) {
        if touching {
            head.moveToLocationWithVelocity(target)
        }
    }
}
