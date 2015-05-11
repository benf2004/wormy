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
    
    init() {
        super.init(textureName: Textures.simpleblack, position : CGPoint(x: 0, y: 0))
    }
    
    override func activate() {
        //intentional no-op
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}