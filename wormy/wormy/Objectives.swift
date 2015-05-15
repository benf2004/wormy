//
//  Objectives.swift
//  wormy
//
//  Created by Finch Gregory on 5/15/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import SpriteKit

protocol Objective {
    func met(scene : BaseScene) -> Bool
}

class LengthObjective : Objective {
    let targetLength : Int
    
    convenience init(properties : NSDictionary) {
        let targetLength = properties["LengthObjective"] as! Int
        self.init(targetLength: targetLength)
    }
    
    init(targetLength : Int) {
        self.targetLength = targetLength
    }
    
    func met(scene : BaseScene) -> Bool {
        if scene.worm.lengthToEnd() >= targetLength {
            return true
        } else {
            return false
        }
    }
}
