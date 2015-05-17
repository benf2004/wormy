//
//  Game.swift
//  wormy
//
//  Created by Finch Gregory on 5/11/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import SpriteKit

struct Game {
    static func randomInRange(lo: Int, hi : Int) -> Int {
        return lo + Int(arc4random_uniform(UInt32(hi - lo + 1)))
    }
    
    static func randomPosition(frame : CGRect) -> CGPoint {
        let randomX = Game.randomX(frame)
        let randomY = Game.randomY(frame)
        return CGPoint(x: randomX, y: randomY)
    }
    
    static func randomXPosition(frame : CGRect, yPosition : Int) -> CGPoint {
        let randomX = Game.randomX(frame)
        return CGPoint(x: randomX, y: yPosition)
    }
    
    static func randomYPosition(frame : CGRect, xPosition : Int) -> CGPoint {
        let randomY = Game.randomY(frame)
        return CGPoint(x: xPosition, y: randomY)
    }
    
    static func randomX(frame : CGRect) -> Int {
        return Game.randomInRange(Int(CGRectGetMinX(frame)), hi: Int(CGRectGetMaxX(frame)))
    }
    
    static func randomY(frame : CGRect) -> Int {
        return Game.randomInRange(Int(CGRectGetMinY(frame)), hi: Int(CGRectGetMaxY(frame)))
    }
    
    //this is too slow.  there are faster fibbonaci algorithms online
    static func fibbonaci(length : Int) -> Int {
        if (length == 0) {return 0}
        else if (length == 1) {return 1}
        else {return (fibbonaci(length-1) + fibbonaci(length-2))}
    }
}
