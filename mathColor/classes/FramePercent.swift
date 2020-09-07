//
//  FramePercent.swift
//  mathColor
//
//  Created by James Wallace on 9/7/20.
//  Copyright © 2020 James Wallace. All rights reserved.
//

import Foundation
import SpriteKit

class FramePercent : SKScene{
    static func percentX(percent: Int) -> CGFloat{
        return CGFloat)frame.maxX) * (percent/100)
    }
    static func percentY(percent: Int) -> CGFloat{
        return CGFloat(frame.maxY) * (percent/100)
    }
}


