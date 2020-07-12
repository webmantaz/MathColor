//
//  MathLevel.swift
//  mathColor
//
//  Created by James Wallace on 7/11/20.
//  Copyright © 2020 James Wallace. All rights reserved.
//

import SpriteKit

class MathLevel {
    
    var levelName : String
    var levelNumber : Int
    var chances : Int
    var minToPass : Int
    var timeToFall : Double
    var numbersToUse : [Int]
    var operators : [String]
    var backgroundColor : String
    var digitImageSet : String
    var missedImagePrefix : String
    var correctImagePrefix : String
    var missedSoundPrefix : String
    var correctSoundPrefix : String
    var soundtrack : String
    var levels: [Level]

    
    init() {
        self.levelName = ""
        self.levelNumber = 0
        self.chances = 0
        self.minToPass = 0
        self.timeToFall = 0.0
        self.numbersToUse = [1]
        self.operators = ["A"]
        self.backgroundColor = ""
        self.digitImageSet = ""
        self.missedImagePrefix = ""
        self.correctImagePrefix = ""
        self.missedSoundPrefix = ""
        self.correctSoundPrefix = ""
        self.soundtrack = ""
        self.levels = Bundle.main.decode([Level].self, from: "levels.json")
        
    }
    
    func getLevel(number:Int)
    {
        let level = levels[number-1]
                
       
        
        
        self.levelName = level.levelName
        self.operators = level.operators
        self.numbersToUse = level.numbersToUse
        self.chances = level.chances
        self.minToPass = level.minToPass
        self.timeToFall = level.timeToFall
        
        
    }
    
}
