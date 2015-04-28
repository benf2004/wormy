//
//  Head.swift
//  wormy
//
//  Created by Finch Gregory on 4/25/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

class HeadNode : Node {
    class func node(location: CGPoint) -> HeadNode {
        let sprite = HeadNode(imageNamed:"Pointed")
        sprite.initialize(location)
        return sprite
    }
    
    func moveToLocationWithVelocity(location: CGPoint) {
        let dt:CGFloat = 5.0/60.0
        let dx = location.x-self.position.x
        let dy = location.y-self.position.y
        let heading = self.heading(location)
        let distance = CGVector(dx: dx, dy: dy)
        let velocity = CGVector(dx: distance.dx/dt, dy: distance.dy/dt)
//        self.zRotation = heading
        self.physicsBody!.velocity=velocity
    }
    
    func heading(location : CGPoint) -> CGFloat {
        let dx = self.position.x - location.x
        let dy = self.position.y - location.y
        if (dy < 0) {
            return -atan(dx / dy) + CGFloat(M_PI_2)
        } else {
            return -atan(dx / dy) - CGFloat(M_PI_2)
        }
    }
}
