//
//  AngryHeadWorm.swift
//  wormy
//
//  Created by Finch Gregory on 5/11/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import SpriteKit

class AngryHeadWorm : HeadWorm {
    var opponent : HeadWorm!
    
    init(position : CGPoint, opponent : HeadWorm) {
        super.init(position: position)
        self.opponent = opponent
    }
    
    override func initialize() {
        let targetBlock = SKAction.runBlock {
            self.target()
        }
        let waitBlock = SKAction.waitForDuration(0.1, withRange: 0.05)
        let sequence = SKAction.sequence([waitBlock, targetBlock])
        let action = SKAction.repeatActionForever(sequence)
        self.runAction(action)
    }
    
    func target() {
        var highestValueTarget = opponent.highestValueNode()
        moveToLocation(highestValueTarget.position)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
