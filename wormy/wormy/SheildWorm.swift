//
//  SheildWorm.swift
//  wormy
//
//  Created by Ben Finch on 5/7/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import Foundation
import SpriteKit
class ShieldWorm : BaseWorm{
    override func activate(){
        if !sheilded {
            head().sheild(true)
            let unsheild = SKAction.runBlock {
                self.head().sheild(false)
            }
            let wait = SKAction.waitForDuration(5)
            let sequence = SKAction.sequence([wait, unsheild])
            self.runAction(sequence)

            
        }
            
    }
}
//        head().sheild(true)
//            let unsheild = SKaction.runBlock {
//             head().sheild(true)
//                let wait = SKAction.waitForDuration(5)
//                head().unshield.true
