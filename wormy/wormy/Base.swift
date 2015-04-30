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
    static let collisionCategory = UInt32(1)
    var tailAnchor : CGPoint = CGPoint()
    var headAnchor : CGPoint = CGPoint()
    
    func initialize(location : CGPoint) {
        self.position = location
        
        let halfWidth = self.size.width / 2
        self.headAnchor = CGPointMake(halfWidth, 0)
        self.tailAnchor = CGPointMake(-halfWidth, 0)
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: halfWidth)
        if let physics = self.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = true
            physics.dynamic = true
            physics.density = 1000
            physics.linearDamping = 4
            physics.angularDamping = 2
        }
    }
        
    func joinToOther(node : Node, physicsWorld : SKPhysicsWorld) {
        var joint = SKPhysicsJointPin.jointWithBodyA(self.physicsBody, bodyB: node.physicsBody, anchor: tailAnchorPosition())
        physicsWorld.addJoint(joint)
    }
    
    func tailAnchorPosition() -> CGPoint {
        return CGPoint(x: self.position.x + tailAnchor.x, y: self.position.y + tailAnchor.y)
    }
    
    func headAnchorPosition() -> CGPoint {
        return CGPoint(x: self.position.x + headAnchor.x, y: self.position.y + headAnchor.y)
    }
}