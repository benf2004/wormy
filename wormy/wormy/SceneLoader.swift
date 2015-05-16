//
//  SceneLoader.swift
//  wormy
//
//  Created by Finch Gregory on 5/13/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import SpriteKit

struct SceneLoader {
    static var currentScene : (String, SKView, BaseScene.Type)? = nil
    
    static func loadScene(name : String, sceneClass : BaseScene.Type) -> SKScene? {
        if let scene = sceneClass.unarchiveFromFile(name) as? BaseScene {
            overlayHUD(scene)
            return scene
        } else {
            return nil
        }
    }
    
    static func transition(scene : SKScene, view: SKView) {
        let transition = SKTransition.fadeWithDuration(0.5)
        scene.scaleMode = SKSceneScaleMode.ResizeFill
        view.presentScene(scene, transition: transition)
    }
    
    static func transitionToScene(name : String, view : SKView, sceneClass : BaseScene.Type) {
        currentScene = (name, view, sceneClass)
        if let scene = loadScene(name, sceneClass: sceneClass) {
            transition(scene, view: view)
        }
    }
    
    static func restartScene() {
        if let scene = currentScene {
            transitionToScene(scene.0, view: scene.1, sceneClass: scene.2)
        }
    }
    
    static func transitionToMenu(view : SKView) {
        if let scene = MenuScene.unarchiveFromFile("Menu") as? MenuScene {
            transition(scene, view: view)
        }
    }
    
    static func overlayHUD(scene : SKScene) {
        if let hud = SKScene.unarchiveFromFile("HUD") as? SKScene {
            for node in hud.children {
                node.removeFromParent()
                scene.addChild(node as! SKNode)
            }
        }
    }
    
    static func loadEffect(name : String) -> SKEmitterNode? {
        return SKEmitterNode.unarchiveFromFile(name) as? SKEmitterNode
    }
    
    static func loadLevelProperties(name : String) -> NSDictionary? {
        if let path = NSBundle.mainBundle().pathForResource(name, ofType: "plist") {
            return NSDictionary(contentsOfFile: path)
        } else {
            return nil
        }
    }
    
    static func currentSceneName() -> String? {
        return currentScene?.0
    }
}
