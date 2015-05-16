//
//  SceneLoader.swift
//  wormy
//
//  Created by Finch Gregory on 5/13/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import SpriteKit

struct CurrentScene {
    init(propertiesName : String, view : SKView, sceneType : BaseScene.Type) {
        self.propertiesName = propertiesName
        self.view = view
        self.sceneType = sceneType
    }
    
    var propertiesName : String!
    var view : SKView!
    var sceneType : BaseScene.Type!
    var sceneName : String!
}

struct SceneLoader {
    static var currentScene : CurrentScene!
    
    static func transitionToScene(propertiesName : String, view : SKView, sceneClass : BaseScene.Type) {
        currentScene = CurrentScene(propertiesName: propertiesName, view: view, sceneType: sceneClass)
        let properties = loadLevelProperties(propertiesName)
        if let scene = loadScene(properties!, sceneClass: sceneClass) {
            transition(scene, view: view)
        }
    }
    
    static func loadScene(properties : NSDictionary, sceneClass : BaseScene.Type) -> SKScene? {
        let sceneName = properties["Scene"] as! String
        if let scene = sceneClass.unarchiveFromFile(sceneName) as? BaseScene {
            overlayHUD(scene)
            return scene
        } else {
            return nil
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
    
    static func transition(scene : SKScene, view: SKView) {
        let transition = SKTransition.fadeWithDuration(0.5)
        scene.scaleMode = SKSceneScaleMode.ResizeFill
        view.presentScene(scene, transition: transition)
    }
    
    static func restartScene() {
        transitionToScene(currentScene.propertiesName, view: currentScene.view, sceneClass: currentScene.sceneType)
    }
    
    static func transitionToMenu(view : SKView) {
        if let scene = MenuScene.unarchiveFromFile("Menu") as? MenuScene {
            transition(scene, view: view)
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
}
