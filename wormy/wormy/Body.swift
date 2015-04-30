//
//  Body.swift
//  wormy
//
//  Created by Finch Gregory on 4/28/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import Foundation
import SpriteKit

class BodyNode : Node {
    class func node(location: CGPoint) -> BodyNode {
        let sprite = BodyNode(imageNamed:"Simple")
        sprite.initialize(location)
        return sprite
    }
}