//
//  GameScene.swift
//  wormy
//
//  Created by Ben Finch on 4/25/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        self.physicsWorld.gravity = CGVectorMake(0.0, -7.9)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let sprite = HeadNode.head(touch.locationInNode(self))
            self.addChild(sprite)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
