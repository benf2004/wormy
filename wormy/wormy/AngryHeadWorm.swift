//
//  AngryHeadWorm.swift
//  wormy
//
//  Created by Finch Gregory on 5/11/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import Foundation
import SpriteKit

class AngryHeadWorm : HeadWorm {
    var opponent : HeadWorm!
    var dormancy : NSTimeInterval!
    
    init(position : CGPoint, opponent : HeadWorm, dormancy : NSTimeInterval) {
        self.dormancy = dormancy
        super.init(position: position, texture: Textures.angryworm)
        self.opponent = opponent
    }
    
    override func initialize() {
        let targetBlock = SKAction.runBlock {
            self.target()
        }
        let waitBlock = SKAction.waitForDuration(0.1, withRange: 0.05)
        let sequence = SKAction.sequence([waitBlock, targetBlock])
        let action = SKAction.repeatActionForever(sequence)
        
        let lieDormant = SKAction.waitForDuration(dormancy)
        self.runAction(SKAction.sequence([lieDormant, action]))
        self.animate()
    }
    
    override func animate() {
        if let leftsmoke = SceneLoader.loadEffect("EarSmoke") {
            leftsmoke.position = CGPointMake(0, (self.size.height / 2))
            self.addChild(leftsmoke)
            leftsmoke.targetNode = self.scene!
        }
        if let rightsmoke = SceneLoader.loadEffect("EarSmoke") {
            rightsmoke.yAcceleration = rightsmoke.yAcceleration * -1
            rightsmoke.emissionAngle = rightsmoke.emissionAngle * -1
            rightsmoke.position = CGPointMake(0, -(self.size.height / 2))
            self.addChild(rightsmoke)
            rightsmoke.targetNode = self.scene!
        }
    }
    
    func target() {
        var highestValueTarget = opponent.highestValueNode()
        moveToLocation(highestValueTarget.position)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
