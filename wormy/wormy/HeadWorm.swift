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
            physics.collisionBitMask = Categories.food | Categories.body
            physics.contactTestBitMask = Categories.food | Categories.body
        }
    }
    
    func consume(food : Food) {
        self.digest(food)
    }
    
    func consume(wormNode : WormNode) {
        if (wormNode.head() !== self) {
            attach(wormNode.head())
        }
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}