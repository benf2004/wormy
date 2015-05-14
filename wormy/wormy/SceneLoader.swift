//
//  SceneLoader.swift
//  wormy
//
//  Created by Finch Gregory on 5/13/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import SpriteKit

struct SceneLoader {
    
    static func loadScene(name : String, sceneClass : BaseScene.Type) -> SKScene? {
        let scene = sceneClass.unarchiveFromFile(name) as? BaseScene
        scene?.scaleMode = .AspectFill
        return scene
    }
    
    static func transition(scene : SKScene, view: SKView) {
        let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 1.0)
        scene.scaleMode = SKSceneScaleMode.AspectFill
        view.presentScene(scene, transition: transition)
    }
    
    static func transitionToScene(name : String, view : SKView, sceneClass : BaseScene.Type) {
        if let scene = loadScene(name, sceneClass: sceneClass) {
            transition(scene, view: view)
        }
    }
    
    static func transitionToMenu(view : SKView) {
        if let scene = MenuScene.unarchiveFromFile("Menu") as? MenuScene {
            transition(scene, view: view)
        }
    }
}
