//
//  AnchorFood.swift
//  wormy
//
//  Created by Finch Gregory on 5/4/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import Foundation
import SpriteKit

class AnchorFood : Food {
    override class func morsel(location: CGPoint) -> Food {
        let sprite = AnchorFood(imageNamed:Textures.simpleblue)
        sprite.initialize(location)
        return sprite
    }
}