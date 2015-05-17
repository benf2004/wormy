//
//  GravityWorm.swift
//  wormy
//
//  Created by Ben Finch on 5/7/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import Foundation
class GravityWorm : BaseWorm{
    override func initialize() {
        targetValue = 2
        physics()?.affectedByGravity = true
    }
    
    override func activate(){
        die()
    }
}