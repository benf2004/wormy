//
//  SheildWorm.swift
//  wormy
//
//  Created by Ben Finch on 5/7/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import Foundation
import SpriteKit
class ShieldWorm : BaseWorm {
    override func initialize() {
        targetValue = 10
    }
    
    override func activate(){
        if !shielded {
            head().shield(true)
            let unshield = SKAction.runBlock {
                self.head().shield(false)
                self.die()
            }
            let wait = SKAction.waitForDuration(5)
            let sequence = SKAction.sequence([wait, unshield])
            self.runAction(sequence)
        }
    }
}
