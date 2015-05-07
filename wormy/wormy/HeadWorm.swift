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
        super.init(scene: scene, textureName: Textures.head)
        self.position = position
        self.animate()
        if let physics = self.physics() {
            physics.categoryBitMask = Categories.head
            physics.collisionBitMask = Categories.food | Categories.body
            physics.contactTestBitMask = Categories.food | Categories.body
        }
    }
    
    override func activate() {
        
    }
    
    func consume(food : Food) {
        self.digest(food)
    }
    
    func consume(wormNode : WormNode) {
        if (wormNode.head() !== self) {
            let prev = wormNode.leading
            let next = wormNode.trailing
            
            wormNode.detachFromTrailing()
            wormNode.detachFromLeading()
            
            (wormNode as! BaseWorm).removeFromParent()
            
            if wormNode is AnchorWorm {
                consume(AnchorFood.morsel(CGPoint(x: 0, y: 0)))
            } else if wormNode is GravityWorm {
                consume(GravityFood.morsel(CGPoint(x: 0, y: 0)))
            } else {
                consume(Food.morsel(CGPoint(x: 0, y: 0)))
            }
            
            next?.moveToLocation(self.position)
            prev?.moveToLocation(self.position)
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