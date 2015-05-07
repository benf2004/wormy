//
//  GravityFood.swift
//  wormy
//
//  Created by Ben Finch on 5/6/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import Foundation
import SpriteKit




class GravityFood : Food {
    override class func morsel(location: CGPoint) -> Food {
        let sprite = GravityFood(imageNamed:Textures.simplered)
        sprite.initialize(location)
        return sprite
    }
}