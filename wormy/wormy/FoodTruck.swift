//
//  FoodTruck.swift
//  wormy
//
//  Created by Finch Gregory on 5/16/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import Foundation

struct FoodTruck {
    init(properties : NSDictionary) {
        if let foodTruck = properties["FoodTruck"] as? NSDictionary {
            foodTruck.enumerateKeysAndObjectsUsingBlock {
                (key, object, stop) -> Void in
                println(key)
                println(object)
            }
        }
    }
}
