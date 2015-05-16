//
//  Activator.swift
//  wormy
//
//  Created by Finch Gregory on 5/15/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import SpriteKit

class Activator : SKSpriteNode {
    init(textureName : String, position: CGPoint) {
        let texture = SKTexture(imageNamed: textureName)
        let color = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        super.init(texture: texture, color: color, size: texture.size())
        self.position = position
        initialize()
    }
    
    func initialize() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        if let physics = self.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.dynamic = false
            physics.categoryBitMask = Categories.activator
            physics.collisionBitMask = Categories.body | Categories.head
            physics.contactTestBitMask = Categories.body | Categories.head
        }
        
        self.position = position
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
