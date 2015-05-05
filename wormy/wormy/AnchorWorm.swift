//
//  AnchorWorm.swift
//  wormy
//
//  Created by Ben Finch on 5/4/15.
//  Copyright (c) 2015 FInch Family. All rights reserved.
//

import Foundation

class AnchorWorm : BaseWorm {
    override func activate() {
        physics()?.mass=3009
    }
}