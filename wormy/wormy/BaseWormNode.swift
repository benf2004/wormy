//
//  BaseSegment.swift
//  wormy
//
//  Created by Finch Gregory on 4/30/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import Foundation
import SpriteKit

class BaseWormNode : SKSpriteNode, WormNode {
    var strength = 5 //todo:  read this from property file

    init(previous : WormNode?, imageName : ImageName) {
        let texture = SKTexture(imageNamed: imageName.rawValue)
        let color = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        super.init(texture: texture, color: color, size: texture.size())
        let halfWidth = self.size.width / 2
        if let neighbor = previous {
            let anchorPosition = neighbor.anchorPosition()
            self.position = CGPoint(x: anchorPosition.x - halfWidth, y: anchorPosition.y)
        }
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: halfWidth)
        if let physics = self.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = true
            physics.dynamic = true
            physics.density = 1000
            physics.linearDamping = 4
            physics.angularDamping = 2
        }
    }
    
    func anchorPosition() -> CGPoint {
        return self.position
    }
    
    func decay() {
        strength = strength - 1
        if (strength == 0) {activate()}
    }
    
    func activate() {}
    func digest(food : Food) {}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}