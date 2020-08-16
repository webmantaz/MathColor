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
    var levelType : String
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
    var multiplicationLevels: [Level]
    var divisionLevels : [Level]
    var additionLevels : [Level]
    var subtractionLevels : [Level]

    
    init() {
        self.levelName = ""
        self.levelNumber = 0
        self.levelType = ""
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
        self.multiplicationLevels = Bundle.main.decode([Level].self, from: "multiplicationLevels.json")
        self.divisionLevels = Bundle.main.decode([Level].self, from: "divisionLevels.json")
        self.additionLevels = Bundle.main.decode([Level].self, from: "additionLevels.json")
        self.subtractionLevels = Bundle.main.decode([Level].self, from: "subtractionLevels.json")
        
        
        
    }
    
    func getLevel(number:Int,levelOperator:OperatorSymbols)
    {
        var tmpNumber = number
        if number == 0
        {
            tmpNumber = 1
        } else {
            tmpNumber = number
        }
        var level = additionLevels[tmpNumber-1]
                
        switch levelOperator {
        case OperatorSymbols.addition:
            level = additionLevels[tmpNumber-1]
        case OperatorSymbols.subtraction:
            level = subtractionLevels[tmpNumber-1]
        case OperatorSymbols.multiplication:
            level = multiplicationLevels[tmpNumber-1]
        case OperatorSymbols.division:
            level = divisionLevels[tmpNumber-1]
        }
                
        self.levelName = level.levelName
        self.levelNumber = level.levelNumber
        self.levelType = level.levelType
        self.operators = level.operators
        self.numbersToUse = level.numbersToUse
        self.chances = level.chances
        self.minToPass = level.minToPass
        self.timeToFall = level.timeToFall
        
        
    }
    
}
