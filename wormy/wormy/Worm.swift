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
    let head : HeadNode
    var body = [Node]()
    
    init(head : HeadNode, scene : SKScene) {
        self.head = head
        scene.addChild(head)
        self.body.append(head)
    }
    
    func grow(bodyNode : BodyNode, scene : SKScene) {
        scene.addChild(bodyNode)
        tail().joinToOther(bodyNode, physicsWorld: scene.physicsWorld)
        self.body.append(bodyNode)
    }
    
    func tail() -> Node {
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