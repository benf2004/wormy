//
//  Protocols.swift
//  wormy
//
//  Created by Finch Gregory on 4/30/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import Foundation
import SpriteKit

protocol WormNode : AnyObject {
    func anchorPosition() -> CGPoint
    func decay()
    func activate()
    func digest(Food)
    func physics() -> SKPhysicsBody?
}

struct Textures {
    static let head = "wormhead"
    static let basic = "Simple"
}

