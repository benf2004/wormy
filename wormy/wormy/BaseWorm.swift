//
//  BaseWorm.swift
//  wormy
//
//  Created by Finch Gregory on 5/2/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import Foundation
import SpriteKit

class BaseWorm : SKSpriteNode {
    var forwardJoint : SKPhysicsJoint? = nil
    var rearwardJoint : SKPhysicsJoint? = nil
    var trailing : BaseWorm? = nil
    var leading : BaseWorm? = nil
    var normalSize : CGFloat? = nil
    var isDigesting : Bool = false
    var hasBeenConsumed : Bool = false
    
    convenience init(textureName : String) {
        self.init(textureName: textureName, position: CGPoint(x: 0,y: 0))
    }
    
    init(textureName : String, position: CGPoint) {
        let texture = SKTexture(imageNamed: textureName)
        let color = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        super.init(texture: texture, color: color, size: texture.size())
        
        normalSize = self.size.width
        let halfWidth = self.size.width / 2
        let quarterWidth = self.size.width / 4
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: halfWidth)
        if let physics = self.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = true
            physics.dynamic = true
            physics.density = 1000
            physics.linearDamping = 4
            physics.angularDamping = 2
            physics.categoryBitMask = Categories.body
        }
        
        self.position = position
    }
    
    func attach(next : BaseWorm) {
        if (isTail()) {
            next.hasBeenConsumed = true
            self.scene!.addChild(next)
            next.affectedByGravity(false)
            next.position = CGPoint(x: position.x - size.width / 2, y: position.y)
            let joint = SKPhysicsJointPin.jointWithBodyA(self.physics(), bodyB: next.physics(), anchor: anchorPosition())
            rearwardJoint = joint
            next.forwardJoint = joint
            trailing = next
            next.leading = self
            head().reorderZ()
            self.scene!.physicsWorld.addJoint(joint)
        } else {
            trailing!.attach(next)
        }
    }
    
    func reorderZ() -> CGFloat {
        if (isTail()) {
            zPosition = 100
        } else {
            zPosition = trailing!.reorderZ()
        }
        return zPosition + 1
    }
    
    func detachFromLeading() {
        if (leading != nil) {
            scene?.physicsWorld.removeJoint(forwardJoint!)
            forwardJoint = nil
            leading!.rearwardJoint = nil
            leading!.trailing = nil
            leading = nil
            affectedByGravity(true)
        }
    }
    
    func detachFromTrailing() {
        if (trailing != nil) {
            scene?.physicsWorld.removeJoint(rearwardJoint!)
            rearwardJoint = nil
            trailing!.forwardJoint = nil
            trailing!.leading = nil
            trailing = nil
        }
    }
    
    func affectedByGravity(affected : Bool) {
        self.physics()?.affectedByGravity = affected
        trailing?.affectedByGravity(affected)
    }
    
    func head() -> BaseWorm {
        if (isHead()) {
            return self
        } else {
            return leading!.head()
        }
    }
    
    func tail() -> BaseWorm {
        if (isTail()) {
            return self
        } else {
            return trailing!.tail()
        }
    }
    
    func isHead() -> Bool {
        if leading == nil {
            return (true)
        } else {
            return false
        }
    }
    
    func isTail() -> Bool {
        if trailing == nil {
            return true
        } else {
            return false
        }
    }
    
    func anchorPosition() -> CGPoint {
        return CGPoint(x: self.position.x - self.size.width / 2, y: self.position.y)
    }
    
    func decay() {
        
    }
    
    func activate() {
        if (hasBeenConsumed) {
            self.detachFromLeading()
            self.detachFromTrailing()
            let location = self.position
            let explosion = BaseExplosion.explosion(location)
            explosion.targetNode = scene!
            scene!.addChild(explosion)
            self.removeFromParent()
        }
    }
    
    func digest(food: BaseWorm) {
        let grow = SKAction.runBlock {
            self.size.width = self.normalSize! * 1.3
            self.size.height = self.normalSize! * 1.3
            self.isDigesting = true
        }
        let wait = SKAction.waitForDuration(0.05)
        let shrink = SKAction.runBlock {
            self.size.width = self.normalSize!
            self.size.height = self.normalSize!
            self.isDigesting = false
        }
        let digestNext = SKAction.runBlock {
            if (self.trailing == nil) {
                self.attach(food)
                self.hidden = false
            } else {
                self.trailing!.digest(food)
            }
        }
        let sequence = SKAction.sequence([grow, wait, shrink, digestNext])
        self.runAction(sequence)
    }
    
    func physics() -> SKPhysicsBody? {
        return self.physicsBody
    }
    
    func moveToLocation(location: CGPoint) {
        let dt:CGFloat = 5.0/60.0
        let dx = location.x-position.x
        let dy = location.y-position.y
        let distance = CGVector(dx: dx, dy: dy)
        let velocity = CGVector(dx: distance.dx/dt, dy: distance.dy/dt)
        physics()!.velocity=velocity
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}