//
//  TestScene.swift
//  wormy
//
//  Created by Finch Gregory on 5/8/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import SpriteKit

class TestScene : BaseScene {
    override func deliverFood(frequency : NSTimeInterval) {
        let wait = SKAction.waitForDuration(frequency)
        let run = SKAction.runBlock {
            let foodType = self.randomInRange(0, hi: 100)
            var food : BaseWorm!
            switch foodType {
            case 0 ... 80 :
                food = BaseWorm(textureName: Textures.simple, position: self.randomPosition())
            case 81 ... 90 :
                food = GravityWorm(textureName: Textures.simplered, position: self.randomPosition())
            case 91 ... 95 :
                food = ShieldWorm(textureName: Textures.simpleblack, position: self.randomPosition())
            default:
                food = AnchorWorm(textureName: Textures.simpleblue, position: self.randomPosition())
            }
            food.sheild(true)
            self.addChild(food)
        }
        
        self.runAction(SKAction.repeatActionForever(SKAction.sequence([wait, run])))
    }
}
