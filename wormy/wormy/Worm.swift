//
//  Worm.swift
//  wormy
//
//  Created by Finch Gregory on 4/28/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import Foundation
import SpriteKit

class Worm {
    let collisionCategory = 1
    let scene : SKScene
    let head : WormHeadNode
    var body = [WormNode]()
    
    init(position : CGPoint, scene : SKScene) {
        self.scene = scene
        self.head = WormHeadNode(position: position, imageName: Textures.head)
        scene.addChild(head)
        self.body.append(head)
    }
    
    func consume(food : Food) {
        //todo : transform food into segment type & digest
        let next = BaseWormNode(previous: tail(), textureName: Textures.basic)
        scene.addChild(next)
        extend(next)
    }
    
    func extend(next : WormNode) {
        if let physics = tail().physics() {
            var joint = SKPhysicsJointPin.jointWithBodyA(physics, bodyB: next.physics()!, anchor: tail().anchorPosition())
            scene.physicsWorld.addJoint(joint)
            self.body.append(next)
        }
    }
    
    func tail() -> WormNode {
        return self.body.last!
    }
    
    func moveToLocation(location: CGPoint) {
        let dt:CGFloat = 5.0/60.0
        let dx = location.x-self.head.position.x
        let dy = location.y-self.head.position.y
        let distance = CGVector(dx: dx, dy: dy)
        let velocity = CGVector(dx: distance.dx/dt, dy: distance.dy/dt)
        self.head.physicsBody!.velocity=velocity
    }
}