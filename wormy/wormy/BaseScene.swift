//
//  BaseScene.swift
//  wormy
//
//  Created by Finch Gregory on 5/7/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import SpriteKit

class BaseScene: SKScene, SKPhysicsContactDelegate {
    var worm: HeadWorm!
    var score: Int = 0
    var timeRemaining: Int = 60
    var objective : Objective? = nil
    
    override func didMoveToView(view: SKView) {
        initialize()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(location)
            if touchedNode.name == "RestartButton" {
                SceneLoader.restartScene()
            }
            if let wormNode = self.nodeAtPoint(location) as? BaseWorm {
                wormNode.activate()
            }
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            worm.moveToLocation(location)
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        var head1 : HeadWorm? = nil
        var head2 : HeadWorm? = nil
        var segment : BaseWorm? = nil
        
        if (contact.bodyA.categoryBitMask == Categories.head &&
            contact.bodyB.categoryBitMask == Categories.body) {
                head1 = contact.bodyA.node as? HeadWorm
                segment = contact.bodyB.node as? BaseWorm
        } else if (contact.bodyA.categoryBitMask == Categories.body &&
            contact.bodyB.categoryBitMask == Categories.head) {
                head1 = contact.bodyB.node as? HeadWorm
                segment = contact.bodyA.node as? BaseWorm
        } else if (contact.bodyA.categoryBitMask == Categories.head &&
            contact.bodyB.categoryBitMask == Categories.head) {
                head1 = contact.bodyA.node as? HeadWorm
                head2 = contact.bodyB.node as? HeadWorm
        }
        
        if let food = segment {
            if (food.headless()) {
                head1?.consume(food)
            } else {
                food.activate()
            }
        }
        
        if let murderer = head2 {
//            head1?.killNeighborsAndDie(head1!.lengthToEnd())
//            murderer.killNeighborsAndDie(murderer.lengthToEnd())
        }
    }
    
    func initialize() {
        initializeObjective()
        placeWorm()
        placeObstacles()
        deliverFood(0.5)
        updateHud()
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 4.9)
    }
    
    func placeWorm() {
        if let wormStub = self.childNodeWithName("Worm") {
            let initialPosition = wormStub.position
            wormStub.removeFromParent()
            worm = HeadWorm(position: initialPosition)
            self.addChild(worm)
            for i in 1...3 {
                worm.consume(NeckWorm())
            }
        }
    }
    
    func placeObstacles() {
        placeHungryWorms()
        placeAngryWorms()
        placeCage()
        placeFire()
    }
    
    func placeHungryWorms() {
        self.enumerateChildNodesWithName("HungryWorm") {
            node, stop in
            let initialPosition = node.position
            node.removeFromParent()
            let hungryWorm = HungryHeadWorm(position: initialPosition)
            self.addChild(hungryWorm)
            for i in 1...3 {
                hungryWorm.consume(NeckWorm())
            }
        }
    }
    
    func placeAngryWorms() {
        self.enumerateChildNodesWithName("AngryWorm") {
            node, stop in
            let initialPosition = node.position
            node.removeFromParent()
            let angryWorm = AngryHeadWorm(position: initialPosition, opponent: self.worm, dormancy: 3)
            self.addChild(angryWorm)
            for i in 1...3 {
                angryWorm.consume(NeckWorm())
            }
        }
    }
    
    func placeCage() {
        self.enumerateChildNodesWithName("Cage") {
            node, stop in
            let uncageWait = SKAction.waitForDuration(5)
            let uncage = SKAction.runBlock {
                node.removeFromParent()
            }
            self.runAction(SKAction.sequence([uncageWait, uncage]))
        }
    }
    
    func placeFire() {
        self.enumerateChildNodesWithName("Fire") {
            node, stop in
            let position = node.position
            node.removeFromParent()
            if let fire = SceneLoader.loadEffect("Fire") {
                fire.position = position
                self.addChild(fire)
            }
        }
    }
    
    func deliverFood(frequency : NSTimeInterval) {
        let wait = SKAction.waitForDuration(frequency)
        let run = SKAction.runBlock {
            var food = BaseWorm(textureName: Textures.simple, position: Game.randomPosition(self.frame))
            food.shield(true)
            self.addChild(food)
        }
        self.runAction(SKAction.repeatActionForever(SKAction.sequence([wait, run])))
    }
    
    func updateHud() {
        let wait = SKAction.waitForDuration(1.0)
        let update = SKAction.runBlock {
            self.score = self.score + self.worm.lengthToEnd()
            self.timeRemaining = self.timeRemaining - 1
            if let label = self.childNodeWithName("LengthLabel") as? SKLabelNode {
                //label.text = String(self.worm.lengthToEnd())
                label.text = String(self.timeRemaining)
            }
        }
        let sequence = SKAction.sequence([update, wait])
        self.runAction(SKAction.repeatActionForever(sequence))
    }
    
    func initializeObjective() {
        if let levelName = scene?.name {
            if let properties = SceneLoader.loadLevelProperties(levelName) {
                if let lengthObjective = properties["LengthObjective"] as? Int {
                    self.objective = LengthObjective(properties: properties)
                }
            }
        }
    }
}
