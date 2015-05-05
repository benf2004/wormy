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
    var forwardJoint : SKPhysicsJoint? {get set}
    var rearwardJoint : SKPhysicsJoint? {get set}
    var trailing : WormNode? {get set}
    var leading : WormNode? {get set}
    var position : CGPoint {get set}
    
    func attach(next : WormNode)
    func reorderZ() -> CGFloat
    func detachFromLeading()
    func detachFromTrailing()
    func affectedByGravity(Bool)
    func isHead() -> Bool
    func isTail() -> Bool
    func head() -> WormNode
    func tail() -> WormNode
    func anchorPosition() -> CGPoint
    func decay()
    func activate()
    func digest(Food)
    func physics() -> SKPhysicsBody?
}

struct Textures {
    static let head = "eyewormhead"
    static let basic = "body"
    static let blink = "blinkywormhead"
    static let simple = "Simple"
}


