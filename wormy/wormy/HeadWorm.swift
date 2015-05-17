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
    convenience init(position : CGPoint) {
        self.init(position: position, texture: Textures.head)
    }
    
    init(position : CGPoint, texture : String) {
        super.init(textureName: texture, position: position)
        if let physics = self.physics() {
            physics.categoryBitMask = Categories.head
            physics.collisionBitMask = Categories.body | Categories.head
            physics.contactTestBitMask = Categories.body | Categories.head
        }
    }
    
    override func initialize() {
        self.animate()
        targetValue = 0
    }
    
    override func activate() {
    }
    
    func consume(wormNode : BaseWorm) {
        let prev = wormNode.leading
        let next = wormNode.trailing
        
        wormNode.detachFromTrailing()
        wormNode.detachFromLeading()
        
        wormNode.removeFromParent()
        self.digest(wormNode)
        
        next?.moveToLocation(self.position)
        prev?.moveToLocation(self.position)
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