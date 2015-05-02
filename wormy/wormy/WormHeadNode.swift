//
//  HeadNode.swift
//  wormy
//
//  Created by Finch Gregory on 5/1/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import Foundation
import SpriteKit

class WormHeadNode : BaseWormNode {
    init(position : CGPoint, imageName : String) {
        super.init(previous: nil, textureName: imageName)
        self.position = position
        if let physics = self.physics() {
            physics.categoryBitMask = Categories.head
            physics.collisionBitMask = Categories.food
            physics.contactTestBitMask = Categories.food
        }
        animate()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func animate() {
        let head_run_anim = SKAction.animateWithTextures([
            SKTexture(imageNamed: Textures.head),
            SKTexture(imageNamed: Textures.blink),
         
            ], timePerFrame: 1)
        
        let run = SKAction.repeatActionForever(head_run_anim)
        
        self.runAction(run, withKey: "running")
    }
    
    
}