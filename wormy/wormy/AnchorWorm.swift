//
//  AnchorWorm.swift
//  wormy
//
//  Created by Ben Finch on 5/4/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import Foundation
import SpriteKit

class AnchorWorm : BaseWorm {
    override func activate() {
        if (!shielded) {
            physics()?.mass=999999999
            let unanchor = SKAction.runBlock {
                self.die()
            }
            let wait = SKAction.waitForDuration(5)
            let sequence = SKAction.sequence([wait, unanchor])
            self.runAction(sequence)
        }
    }
}