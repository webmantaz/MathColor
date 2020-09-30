//
//  Level.swift
//  mathColor
//
//  Created by James Wallace on 7/10/20.
//  Copyright © 2020 James Wallace. All rights reserved.
//

import SpriteKit

struct Level : Codable
{
    let levelName : String
    let levelNumber : Int
    let levelType : String
    let levelCase : String
    let chances : Int
    let minToPass : Int
    let timeToFall : Double
    let numbersToUse : [Int]
    let operators : [String]
    let backgroundColor : String
    let digitImageSet : String
    let missedImagePrefix : String
    let correctImagePrefix : String
    let missedSoundPrefix : String
    let correctSoundPrefix : String
    let soundtrack : String
    
}
