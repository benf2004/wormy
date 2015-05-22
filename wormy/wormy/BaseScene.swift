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
    var levelProperties : NSDictionary? = nil
    var foodTruck : FoodTruck!
    
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
            if touchedNode.name == "Menu" {
                SceneLoader.transitionToMenu(self.view!)
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
        } else if (contact.bodyA.categoryBitMask == Categories.obstacle) {
            if let activator = contact.bodyA.node as? Activator {
                if let collidor = contact.bodyB.node as? BaseWorm {
                    collidor.activate()
                }
            } else if let brick = contact.bodyA.node as? Dirt {
                brick.transformToPebbles()
            } else if let pebble = contact.bodyA.node as? SKSpriteNode {
                if (pebble.name == Textures.pebble) {
                    pebble.removeFromParent()
                }
            }
        } else if (contact.bodyB.categoryBitMask == Categories.obstacle) {
            if let activator = contact.bodyB.node as? Activator {
                if let collidor = contact.bodyA.node as? BaseWorm {
                    collidor.activate()
                }
            } else if let brick = contact.bodyB.node as? Dirt {
                brick.transformToPebbles()
            } else if let pebble = contact.bodyB.node as? SKSpriteNode {
                if (pebble.name == Textures.pebble) {
                    pebble.removeFromParent()
                }
            }
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
        intializeProperties()
        initializeObjective()
        placeWorm()
        placeObstacles()
        initializeFoodTruck()
        initializeHud()
        showInitialMessage()
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 4.9)
    }
    
    func placeWorm() {
        if let wormStub = self.childNodeWithName("Worm") {
            let initialPosition = wormStub.position
            wormStub.removeFromParent()
            worm = HeadWorm(position: initialPosition)
            self.addChild(worm)
            worm.initialize()
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
        placeActivators()
        placeBricks()
    }
    
    func placeHungryWorms() {
        self.enumerateChildNodesWithName("HungryWorm") {
            node, stop in
            let initialPosition = node.position
            node.removeFromParent()
            let hungryWorm = HungryHeadWorm(position: initialPosition)
            self.addChild(hungryWorm)
            hungryWorm.initialize()
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
            angryWorm.initialize()
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
            let fireActivator = FireActivator(textureName: Textures.blank, position: position)
            self.addChild(fireActivator)
            if let fire = SceneLoader.loadEffect("Fire") {
                fire.position = position
                self.addChild(fire)
            }
        }
    }
    
    func placeActivators() {
        self.enumerateChildNodesWithName("Activator") {
            node, stop in
            let position = node.position
            node.removeFromParent()
            let activator = Activator(textureName: Textures.activator, position: position)
            self.addChild(activator)
        }
    }
    
    func placeBricks() {
        self.enumerateChildNodesWithName("Bricks") {
            node, stop in
            let wall = node as! SKSpriteNode
            let position = node.position
            let spriteTemplate = Dirt(imageNamed: Textures.brick)
            let brickSize = spriteTemplate.size
            let originx = position.x - wall.size.width / 2
            let originy = position.y - wall.size.height / 2
            let width = Int(wall.size.width / brickSize.width)
            let height = Int(wall.size.height / brickSize.height)
            wall.removeFromParent()
            for i in 0...width {
                for j in 0...height {
                    let brick = Dirt(imageNamed: Textures.brick)
                    brick.name = Textures.brick
                    brick.position.x = originx + (CGFloat(i) * brickSize.width)
                    brick.position.y = originy + (CGFloat(j) * brickSize.height)
                    brick.physicsBody = SKPhysicsBody(rectangleOfSize: brickSize)
                    if let physics = brick.physicsBody {
                        physics.affectedByGravity = false
                        physics.allowsRotation = false
                        physics.dynamic = false
                        physics.friction = 0
                        physics.categoryBitMask = Categories.obstacle
                    }
                    
                    self.addChild(brick)
                }
            }
        }
    }
    
    func initializeFoodTruck() {
        self.foodTruck = FoodTruck(properties: levelProperties!)
        
        var frequency = levelProperties!["FoodFrequency"] as? NSTimeInterval
        if (frequency == nil) {
            frequency = 0.5
        }
        let wait = SKAction.waitForDuration(frequency!)
        let run = SKAction.runBlock {
            let position = Game.randomPosition(self.view!.frame)
            var food = self.foodTruck.randomFood(position)
            food.shield(true)
            self.addChild(food)
            food.initialize()
        }
        self.runAction(SKAction.repeatActionForever(SKAction.sequence([wait, run])))
    }
    
    func initializeHud() {
        if let properties = levelProperties {
            self.timeRemaining = properties["SecondsAllowed"] as! Int
        }
        let wait = SKAction.waitForDuration(1.0)
        let update = SKAction.runBlock {
            //self.score = self.score + self.worm.lengthToEnd()
            self.timeRemaining = self.timeRemaining - 1
            if let levelObjective = self.objective {
                if levelObjective.met(self) {
                    self.endLevel(true)
                } else if self.timeRemaining <= 0 {
                    self.timeRemaining = 0
                    self.endLevel(false)
                }
            }
            if let label = self.childNodeWithName("LengthLabel") as? SKLabelNode {
                label.text = String(self.worm.lengthToEnd())
            }
            if let totalScoreLabel = self.childNodeWithName("TotalScore") as? SKLabelNode {
                totalScoreLabel.text = String(self.score)
            }
            if let timer = self.childNodeWithName("Timer") as? SKLabelNode {
                timer.text = String(self.timeRemaining)
            }
        }
        let sequence = SKAction.sequence([update, wait])
        self.runAction(SKAction.repeatActionForever(sequence))
    }
    
    func intializeProperties() {
        if let levelName = SceneLoader.currentScene.propertiesName {
            levelProperties = SceneLoader.loadLevelProperties(levelName)
        }
    }
    
    func initializeObjective() {
        if let properties = levelProperties {
            if let lengthObjective = properties["LengthObjective"] as? Int {
                self.objective = LengthObjective(targetLength: lengthObjective)
            }
        }
    }
    
    func showMessage(message : String, duration : NSTimeInterval) {
        let wait = SKAction.waitForDuration(duration)
        if let messageLabel = self.childNodeWithName("Message") as? SKLabelNode {
            messageLabel.text = message
        }
        let erase = SKAction.runBlock {
            if let messageLabel = self.childNodeWithName("Message") as? SKLabelNode {
                messageLabel.text = ""
            }
        }
        self.runAction(SKAction.sequence([wait, erase]))
    }
    
    func showInitialMessage() {
        if let properties = levelProperties {
            if let initialMessage = properties["InitialMessage"] as? String {
                showMessage(initialMessage, duration: 3)
            }
        }
    }
    
    func endLevel(success : Bool) {
        let wait = SKAction.waitForDuration(3)
        if (success) {
            showMessage("You Win!", duration: 2)
            let transition = SKAction.runBlock {
                SceneLoader.transitionToMenu(self.view!)
            }
            self.runAction(SKAction.sequence([wait, transition]))
        } else {
            showMessage("You Lose!", duration: 2)
            let transition = SKAction.runBlock {
                SceneLoader.restartScene()
            }
            self.runAction(SKAction.sequence([wait, transition]))
        }
    }
}
