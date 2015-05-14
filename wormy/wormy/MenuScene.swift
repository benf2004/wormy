//
//  MenuScene.swift
//  wormy
//
//  Created by Finch Gregory on 5/13/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import SpriteKit

class MenuScene : SKScene {
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(location)
            if let name = touchedNode.name {
                SceneLoader.transitionToScene(name, view: self.scene!.view!, sceneClass: BaseScene.self)
            }
        }
    }
}
