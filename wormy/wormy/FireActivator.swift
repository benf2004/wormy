//
//  FireActivator.swift
//  wormy
//
//  Created by Finch Gregory on 5/15/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import SpriteKit

class FireActivator : Activator {
    override func initialize() {
        self.size.width = 41
        self.size.height = 74
        self.position.y = self.position.y + 20
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        if let physics = self.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.dynamic = false
            physics.categoryBitMask = Categories.activator
            physics.contactTestBitMask = Categories.body | Categories.head
        }
    }
}
