//
//  FoodTruck.swift
//  wormy
//
//  Created by Finch Gregory on 5/16/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import Foundation
import SpriteKit

struct FoodTruck {
    var foodTypes : Array<String> = []
    var frequencies : Array<Int> = []
    
    init(properties : NSDictionary) {
        if let foodTruck = properties["FoodTruck"] as? NSDictionary {
            for (food, frequency) in foodTruck {
                foodTypes.append(food as! String)
                frequencies.append(frequency as! Int)
            }
        }
    }
    
    func randomFoodType() -> String {
        var random = Game.randomInRange(0, hi: 99)
        var total = 0
        for (i, val) in enumerate(frequencies) {
            total = total + val
            if random < total {
                return foodTypes[i]
            }
        }
        return foodTypes.last!
    }
    
    func randomFood(position : CGPoint) -> BaseWorm {
        switch randomFoodType() {
        case "GravityWorm":
            return GravityWorm(textureName: Textures.simplered, position : position)
        case "SheildWorm":
            return ShieldWorm(textureName: Textures.simpleblack, position : position)
        case "AnchorWorm":
            return AnchorWorm(textureName: Textures.simpleblue, position : position)
        default:
            return BaseWorm(textureName: Textures.simple, position : position)
        }
    }
}
