//
//  TestScene.swift
//  wormy
//
//  Created by Finch Gregory on 5/8/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import SpriteKit

class TestScene : BaseScene {
    
    override func placeObstacles() {
        let dormancy : NSTimeInterval = 4
        let wait = SKAction.waitForDuration(0.5)
        let buildAngryWorm = SKAction.runBlock {
            if let angryStub = self.childNodeWithName("AngryWorm") {
                let initialPosition = angryStub.position
                angryStub.removeFromParent()
//                let angryWorm = AngryHeadWorm(position: initialPosition, opponent: self.worm, dormancy: dormancy)
                for j in 1...7 {
                    let angryWorm = HungryHeadWorm(position: Game.randomPosition(self.frame))
                    self.addChild(angryWorm)
                    for i in 1...3 {
                        angryWorm.consume(NeckWorm())
                    }
                }
            }
        }
        self.runAction(SKAction.sequence([wait, buildAngryWorm]))
        
        self.enumerateChildNodesWithName("Cage") {
            node, stop in
            let uncageWait = SKAction.waitForDuration(5)
            let uncage = SKAction.runBlock {
                node.removeFromParent()
            }
            self.runAction(SKAction.sequence([uncageWait, uncage]))
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
