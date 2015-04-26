//
//  Head.swift
//  wormy
//
//  Created by Finch Gregory on 4/25/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import UIKit
import SpriteKit

class HeadNode: SKSpriteNode {
    class func head(location: CGPoint) -> HeadNode {
        let sprite = HeadNode(imageNamed:"Simple")
        
        sprite.xScale = 1
        sprite.yScale = 1
        sprite.position = location
        
        sprite.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "Simple"), size: sprite.size)
        if let physics = sprite.physicsBody {
            physics.affectedByGravity = true
            physics.allowsRotation = true
            physics.dynamic = true;
            physics.linearDamping = 2
            physics.angularDamping = 2
        }
        return sprite
    }
}
