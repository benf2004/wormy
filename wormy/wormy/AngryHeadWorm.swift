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
        
        let targetBlock = SKAction.runBlock {
            self.target()
        }
        let waitBlock = SKAction.waitForDuration(3, withRange: 2)
        let sequence = SKAction.sequence([waitBlock, targetBlock])
        SKAction.repeatActionForever(sequence)
    }
    
    func target() {
        var nextPosition : CGPoint = Game.randomPosition(self.scene!.frame)
        //todo:: find the highest value segment in worm and aim for it.
        moveToLocation(nextPosition)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
