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
    var head : WormHeadNode? = nil
    var scene : GameScene
    var body = [WormNode]()
    var joints = [SKPhysicsJoint]()
    
    init(position : CGPoint, scene : GameScene) {
        self.scene = scene
        self.head = WormHeadNode(position: position, imageName: Textures.head)
        scene.addChild(self.head!)
        self.body.append(self.head!)
    }
    
    init(body : [WormNode], joints : [SKPhysicsJoint], scene : GameScene) {
        self.body = body
        self.joints = joints
        self.scene = scene
        if let head = self.body[0] as? WormHeadNode {
            self.head = head
        }
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
            self.joints.append(joint)
        }
    }
    
    func divide(node : WormNode) {
        if let index = indexOfWormNode(node) {
            println(index)
            let rightWorm = buildRightWorm(index)
            let leftWorm = buildLeftWorm(index)
            
            if let left = leftWorm {
                println("loading left")
                scene.worm = left
            } else {
                println("loading right")
                scene.worm = rightWorm!
            }
            
            if index > 0 {
              scene.physicsWorld.removeJoint(joints[index-1])
            }
            if index < joints.endIndex {
              scene.physicsWorld.removeJoint(joints[index])
            }
            body[index].activate()
        }
    }
        
    func buildLeftWorm(index : Int) -> Worm? {
        var leftWormBody = [WormNode]()
        var leftWormJoints = [SKPhysicsJoint]()
        for i in 0...index {
            leftWormBody.append(body[i])
        }
        if (index > 0) {
            for i in 0...index-1 {
                leftWormJoints.append(joints[i])
            }
        }
        
        if (leftWormBody.count > 0) {
            return Worm(body: leftWormBody, joints: leftWormJoints, scene: scene)
        } else {
            return nil
        }
    }
    
    func buildRightWorm(index : Int) -> Worm? {
        var rightWormBody = [WormNode]()
        var rightWormJoints = [SKPhysicsJoint]()
        for i in index..<body.endIndex {
            rightWormBody.append(body[i])
        }
        for i in index..<joints.endIndex {
            rightWormJoints.append(joints[i])
        }
        if (rightWormBody.count > 0) {
            return Worm(body: rightWormBody, joints: rightWormJoints, scene: scene)
        } else {
            return nil
        }
    }
    
    func indexOfWormNode(node : WormNode) -> Int? {
        for (index, bodyNode) in enumerate(body) {
            if (node === bodyNode) {return index}
        }
        return nil
    }
    
    func tail() -> WormNode {
        return self.body.last!
    }
    
    func moveToLocation(location: CGPoint) {
        if let headToMove = head {
            let dt:CGFloat = 5.0/60.0
            let dx = location.x-headToMove.position.x
            let dy = location.y-headToMove.position.y
            let distance = CGVector(dx: dx, dy: dy)
            let velocity = CGVector(dx: distance.dx/dt, dy: distance.dy/dt)
            headToMove.physicsBody!.velocity=velocity
        }
    }
}