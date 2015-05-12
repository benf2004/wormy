//
//  TestScene.swift
//  wormy
//
//  Created by Finch Gregory on 5/8/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import SpriteKit

class TestScene : BaseScene {
    override func placeWorm() {
        super.placeWorm()
        let wanderer = AngryHeadWorm(position: Game.randomPosition(self.frame), opponent: worm)
        self.addChild(wanderer)
        for i in 1...5 {
            wanderer.consume(NeckWorm())
        }
    }
    
    override func deliverFood(frequency : NSTimeInterval) {
        let wait = SKAction.waitForDuration(frequency)
        let run = SKAction.runBlock {
            let foodType = Game.randomInRange(0, hi: 100)
            var food : BaseWorm!
            let newPosition = Game.randomPosition(self.frame)
            switch foodType {
            case 0 ... 80 :
                food = BaseWorm(textureName: Textures.simple, position: newPosition)
            case 81 ... 90 :
                food = GravityWorm(textureName: Textures.simplered, position: newPosition)
            case 91 ... 95 :
                food = ShieldWorm(textureName: Textures.simpleblack, position: newPosition)
            default:
                food = AnchorWorm(textureName: Textures.simpleblue, position: newPosition)
            }
            food.shield(true)
            self.addChild(food)
        }
        
        self.runAction(SKAction.repeatActionForever(SKAction.sequence([wait, run])))
    }
}
