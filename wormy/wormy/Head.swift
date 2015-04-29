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
}
