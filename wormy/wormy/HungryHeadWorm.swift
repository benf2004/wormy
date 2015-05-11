//
//  HungryHeadWorm.swift
//  wormy
//
//  Created by Finch Gregory on 5/11/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import SpriteKit

class HungryHeadWorm : HeadWorm {
    override init(position : CGPoint) {
        super.init(position: position)
        let wanderBlock = SKAction.runBlock {
            self.targetFood()
        }
        let waitBlock = SKAction.waitForDuration(3, withRange: 2)
        let sequence = SKAction.sequence([waitBlock, wanderBlock])
        SKAction.repeatActionForever(sequence)
    }
    
    func targetFood() {
        //todo ... how to find where the food is?
        let nextPosition = Game.randomPosition(self.scene!.frame)
        moveToLocation(nextPosition)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
