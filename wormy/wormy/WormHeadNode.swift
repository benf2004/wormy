//
//  HeadNode.swift
//  wormy
//
//  Created by Finch Gregory on 5/1/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import Foundation
import SpriteKit

class WormHeadNode : BaseWormNode {
    init(position : CGPoint, imageName : ImageName) {
        super.init(previous: nil, imageName: imageName)
        self.position = position
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}