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
            let foodType = Game.randomInRange(0, hi: 100)
            var food : BaseWorm!
            switch foodType {
            case 0 ... 80 :
                food = BaseWorm(textureName: Textures.simple, position: Game.randomPosition(self.frame))
            case 81 ... 90 :
                food = GravityWorm(textureName: Textures.simplered, position: Game.randomPosition(self.frame))
            case 91 ... 95 :
                food = ShieldWorm(textureName: Textures.simpleblack, position: Game.randomPosition(self.frame))
            default:
                food = AnchorWorm(textureName: Textures.simpleblue, position: Game.randomPosition(self.frame))
            }
            food.shield(true)
            self.addChild(food)
        }
        self.runAction(SKAction.repeatActionForever(SKAction.sequence([wait, run])))
    }
}
