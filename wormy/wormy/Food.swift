//
//  Food.swift
//  wormy
//
//  Created by Finch Gregory on 4/28/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import Foundation
import SpriteKit

class Food : SKSpriteNode {
    class func morsel(location: CGPoint) -> Food {
        let sprite = Food(imageNamed:"body")
        sprite.initialize(location)
        return sprite
    }
    
    func initialize(location : CGPoint) {
        self.xScale = 1
        self.yScale = 1
        self.position = location
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2)
        if let physics = self.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.dynamic = false
            physics.density = 1000000
            physics.categoryBitMask = Categories.food
        }
    }
}