//
//  Dirt.swift
//  wormy
//
//  Created by Finch Gregory on 5/21/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import SpriteKit

class Dirt : SKSpriteNode {
    func transformToPebbles() {
        if let scene = self.scene {
            if let explosion = SceneLoader.loadEffect("Pebbles") {
                explosion.position = self.position
                scene.addChild(explosion)
            }
            self.removeFromParent()
        }
    }
}
