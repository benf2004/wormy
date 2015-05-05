//
//  Explosions.swift
//  wormy
//
//  Created by Finch Gregory on 5/2/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import Foundation
import SpriteKit

class BaseExplosion : SKEmitterNode {
    class func explosion(position : CGPoint) -> BaseExplosion {
        let explosion = BaseExplosion.init()
        explosion.position = position
        explosion.particleTexture = SKTexture(imageNamed: Textures.basic)
        explosion.particleColor = UIColor.purpleColor()
        explosion.numParticlesToEmit = 100
        explosion.particleBirthRate = 450
        explosion.particleLifetime = 1.2
        explosion.emissionAngleRange = 360
        explosion.particleSpeed = 100
        explosion.particleSpeedRange = 50
        explosion.xAcceleration = 0
        explosion.yAcceleration = 0
        explosion.particleAlpha = 0.8
        explosion.particleAlphaRange = 0.2
        explosion.particleAlphaSpeed = -0.5
        explosion.particleScale = 0.75
        explosion.particleScaleRange = 0.4
        explosion.particleScaleSpeed = -0.5
        explosion.particleRotation = 0
        explosion.particleRotationRange = 0
        explosion.particleRotationSpeed = 0
        explosion.particleColorBlendFactor = 1
        explosion.particleColorBlendFactorRange = 0
        explosion.particleColorBlendFactorSpeed = 0
        explosion.particleBlendMode = SKBlendMode.Add
        explosion.particleZPosition = 500
        
        return explosion
    }
}