//
//  HeadWorm.swift
//  wormy
//
//  Created by Finch Gregory on 5/2/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import Foundation
import SpriteKit

class HeadWorm : BaseWorm {
    init(position : CGPoint, scene : SKScene) {
        super.init(scene: scene)
        self.position = position
        self.animate()
        if let physics = self.physics() {
            physics.categoryBitMask = Categories.head
            physics.collisionBitMask = Categories.food
            physics.contactTestBitMask = Categories.food
        }
    }
    
    func consume(food : Food) {
        self.digest(food)
    }
    
    func animate() {
        let head_run_anim = SKAction.animateWithTextures([
            SKTexture(imageNamed: Textures.head),
            SKTexture(imageNamed: Textures.head),
            SKTexture(imageNamed: Textures.head),
            SKTexture(imageNamed: Textures.blink),
            ], timePerFrame: 1)
        let run = SKAction.repeatActionForever(head_run_anim)
        self.runAction(run, withKey: "running")
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