//
//  Head.swift
//  wormy
//
//  Created by Finch Gregory on 4/25/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import UIKit
import SpriteKit

class HeadNode : SKSpriteNode {
    var halfWidth : CGFloat = 0.0
    var tailAnchor : CGPoint = CGPoint()
    var headAnchor : CGPoint = CGPoint()
    
    class func head(location: CGPoint) -> HeadNode {
        let sprite = HeadNode(imageNamed:"Simple")
        sprite.xScale = 1
        sprite.yScale = 1
        sprite.position = location
        
        sprite.halfWidth = sprite.size.width / 2
        
        sprite.physicsBody = SKPhysicsBody(circleOfRadius: sprite.halfWidth)
        if let physics = sprite.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.dynamic = true
            physics.linearDamping = 0.55
            physics.angularDamping = 0.55
            physics.restitution = 0.25
        }
        return sprite
    }
    
    func moveToLocationWithVelocity(location: CGPoint) {
        let dt:CGFloat = 5.0/60.0
        let distance = CGVector(dx: location.x-self.position.x, dy: location.y-self.position.y)
        let velocity = CGVector(dx: distance.dx/dt, dy: distance.dy/dt)
        self.physicsBody!.velocity=velocity
    }
    
    func joinToOther(node : HeadNode, physicsWorld : SKPhysicsWorld) {
        var joint = SKPhysicsJointSpring.jointWithBodyA(self.physicsBody, bodyB: node.physicsBody, anchorA: self.tailAnchor, anchorB: node.headAnchor)
        joint.frequency = 3
        joint.damping = 1
        physicsWorld.addJoint(joint)
    }
}
