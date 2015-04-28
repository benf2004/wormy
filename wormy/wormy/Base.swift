//
//  Base.swift
//  wormy
//
//  Created by Finch Gregory on 4/28/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import Foundation
import SpriteKit

class Node : SKSpriteNode {
    var halfWidth : CGFloat = 0.0
    var tailAnchor : CGPoint = CGPoint()
    var headAnchor : CGPoint = CGPoint()
    
    func initialize(location : CGPoint) {
        self.xScale = 1
        self.yScale = 1
        self.position = location
        
        self.halfWidth = self.size.width / 2
        headAnchor = CGPointMake(CGRectGetMaxX(self.frame), CGRectGetMidY(self.frame))
        tailAnchor = CGPointMake(CGRectGetMinX(self.frame), CGRectGetMidY(self.frame))
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.halfWidth)
        if let physics = self.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = true
            physics.dynamic = true
        }
    }
        
//    func joinToOther(node : Node, physicsWorld : SKPhysicsWorld) {
//        var joint = SKPhysicsJointLimit.jointWithBodyA(self.physicsBody, bodyB: node.physicsBody, anchorA: self.tailAnchor, anchorB: node.headAnchor)
//        joint.maxLength = 5
//        physicsWorld.addJoint(joint)
//    }
    func joinToOther(node : Node, physicsWorld : SKPhysicsWorld) {
        var joint = SKPhysicsJointPin.jointWithBodyA(self.physicsBody, bodyB: node.physicsBody, anchor: self.tailAnchor)
        physicsWorld.addJoint(joint)
    }
}