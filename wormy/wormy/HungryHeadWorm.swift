//
//  HungryHeadWorm.swift
//  wormy
//
//  Created by Finch Gregory on 5/11/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import SpriteKit

class HungryHeadWorm : HeadWorm {
    var food : BaseWorm? = nil
    
    override init(position : CGPoint) {
        super.init(position: position)
        let targetBlock = SKAction.runBlock {
            self.targetFood()
        }
        let waitBlock = SKAction.waitForDuration(0.1, withRange: 0.05)
        let sequence = SKAction.sequence([waitBlock, targetBlock])
        let gotoTarget = SKAction.repeatActionForever(sequence)
        
        let findFood = SKAction.runBlock {
            self.target()
        }
        let findWait = SKAction.waitForDuration(2)
        let findTarget = SKAction.repeatActionForever(SKAction.sequence([findFood, findWait]))
        
        self.runAction(gotoTarget)
        self.runAction(findTarget)
    }
    
    func targetFood() {
        if let foodTarget = food {
            moveToLocation(foodTarget.position)
        }
    }
    
    func target() {
        food = nil
        if let myScene = scene {
            var j = Game.randomInRange(0, hi: myScene.children.count-1)
            for (var i = 0; food == nil && i < myScene.children.count; ++i) {
                if let potentialTarget = myScene.children[j] as? BaseWorm {
                    if potentialTarget.headless() && myScene.view!.bounds.contains(potentialTarget.position) {
                        food = potentialTarget
                    }
                }
                ++j; if j == myScene.children.count {j=0}
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
