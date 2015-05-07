//
//  NeckWorm.swift
//  wormy
//
//  Created by Finch Gregory on 5/4/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import Foundation
import SpriteKit

//The neck of the worm cannot be activated or decayed.
class NeckWorm : BaseWorm {
    
    override init(scene: SKScene, textureName: String) {
        super.init(scene: scene, textureName: textureName)
        physics()?.categoryBitMask = 0 //no collisions with neck
    }
    
    override func activate() {
        //intentional no-op
    }
    
    override func decay() {
        //intentional no-op
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}