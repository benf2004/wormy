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
    var tail: BodyNode!
    var target: CGPoint = CGPoint()
    var touching = false
    override func didMoveToView(view: SKView) {
        head = HeadNode.node(CGPoint(x:self.size.width - 20, y:self.size.height / 2))
        self.addChild(head)
        
        var prev : Node = head
        for i in 1...10 {
            let seg = BodyNode.node(CGPoint(x:prev.position.x-prev.size.width, y:prev.position.y))
            self.addChild(seg)
            prev.joinToOther(seg, physicsWorld: self.physicsWorld)
            prev = seg
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            head.moveToLocationWithVelocity(location)
//            if head.frame.contains(location) {
//                target = location
//                touching = true
//            }
        }
//        for touch: AnyObject in touches {
//            let sprite = HeadNode.head(touch.locationInNode(self))
//            self.addChild(sprite)
//        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
//            target = location
            head.moveToLocationWithVelocity(location)
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent)  {
        touching = false
    }
   
    override func update(currentTime: CFTimeInterval) {
//        if touching {
//            head.moveToLocationWithVelocity(target)
//        }
    }
}
