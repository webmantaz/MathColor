//
//  MultiImageNode.swift
//  mathColor
//
//  Created by James Wallace on 8/15/20.
//  Copyright © 2020 James Wallace. All rights reserved.
//

import Foundation
import SpriteKit

class MultiImageNode : SKNode
{
    var numberOfImages = 0
    var imageName = ""
        
    override init() {
        numberOfImages = 1
        imageName = ""
        super.init()
        // buildNode()
    }
    
    init(imageName: String, numberOfImages: Int)
    {
        self.imageName = imageName
        self.numberOfImages = numberOfImages
        super.init()
        buildNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("We aren't using storyboards")
    }
    
    private func buildNode()
    {
        for number in 1...self.numberOfImages
        {
            let tmpNode = SKSpriteNode(imageNamed: self.imageName)
            let imageWidth = tmpNode.size.width
            tmpNode.name = "multiimage"
            tmpNode.position = CGPoint(x: self.position.x+imageWidth*CGFloat(number-1), y: self.position.y)
            self.addChild(tmpNode)
        }
    }
}
