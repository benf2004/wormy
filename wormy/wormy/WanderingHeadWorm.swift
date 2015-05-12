//
//  WanderingHeadWorm.swift
//  wormy
//
//  Created by Finch Gregory on 5/11/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import SpriteKit

class WanderingHeadWorm : HeadWorm {
    override init(position : CGPoint) {
        super.init(position: position)
    }
    
    override func initialize() {
        let wanderBlock = SKAction.runBlock {
            self.wander()
        }
        let waitBlock = SKAction.waitForDuration(3)
        let sequence = SKAction.sequence([waitBlock, wanderBlock])
        let action = SKAction.repeatActionForever(sequence)
        self.runAction(action)
    }
    
    func wander() {
        let nextPosition = Game.randomPosition(self.scene!.frame)
        moveToLocation(nextPosition)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
