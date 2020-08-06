//
//  OperatorString.swift
//  mathColor
//
//  Created by James Wallace on 6/27/20.
//  Copyright © 2020 James Wallace. All rights reserved.
//

import Foundation
import SpriteKit


class Tries
{
    var triesLeft = 0
    var imageName = ""
    
    init(tries: Int, image: String) {
        self.triesLeft = tries
        self.imageName = image
    }

    func buildNode() -> SKNode
    {
        let triesParentNode : SKNode
        triesParentNode = SKNode()
        for number in 1...self.triesLeft
        {
            let tmpNode = SKSpriteNode(imageNamed: self.imageName)
            tmpNode.position = CGPoint(x: triesParentNode.position.x+CGFloat(80*(number-1)), y: triesParentNode.position.y)
            triesParentNode.addChild(tmpNode)
        }
        
        return triesParentNode
    }

}

