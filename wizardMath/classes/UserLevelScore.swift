//
//  UserLevelScore.swift
//  wizardMath
//
//  Created by James Wallace on 1/18/21.
//  Copyright © 2021 James Wallace. All rights reserved.
//

import Foundation
import SpriteKit

class UserLevelScore
{
    var additionLevels:[String: String] = [:]
    var subtractionLevels:[String: String] = [:]
    var multiplicationLevels:[String: String] = [:]
    var divisionLevels:[String: String] = [:]
    
    func putLevelScore(Operaotor:OperatorSymbols, Level:Int, Score:Int, Stars:Int)
    {
        let stringLevel = String(Level)
        switch Operaotor {
        case .addition:
            additionLevels.updateValue(String(Score)+"_"+String(Stars), forKey: stringLevel)
        case .division:
            divisionLevels.updateValue(String(Score)+"_"+String(Stars), forKey: stringLevel)
        case .multiplication:
            multiplicationLevels.updateValue(String(Score)+"_"+String(Stars), forKey: stringLevel)
        case .subtraction:
            subtractionLevels.updateValue(String(Score)+"_"+String(Stars), forKey: stringLevel)
        }
    }
    
    func getLevelScore(Operator:OperatorSymbols, Level:Int) -> Int
    {
        let levelString = String(Level)
        var score = 0
        var scoreArray = [String]()
        switch Operator {
        case .addition:
            let scoreString = String(additionLevels[levelString]!)
            scoreArray = scoreString.components(separatedBy: "_")
            score = Int(scoreArray[0])!
        case .division:
            let scoreString = divisionLevels[levelString]!
            scoreArray = scoreString.components(separatedBy: "_")
            score = Int(scoreArray[0])!
        case .multiplication:
            let scoreString = multiplicationLevels[levelString]!
            scoreArray = scoreString.components(separatedBy: "_")
            score = Int(scoreArray[0])!
        case .subtraction:
            let scoreString = subtractionLevels[levelString]!
            scoreArray = scoreString.components(separatedBy: "_")
            score = Int(scoreArray[0])!
        }
        return score
    }
    
    func getLevelStars(Operator:OperatorSymbols, Level:Int) -> Int
    {
        let levelString = String(Level)
        var stars = 0
        var starsArray = [String]()
        switch Operator {
        case .addition:
            let starsString = String(additionLevels[levelString]!)
            starsArray = starsString.components(separatedBy: "_")
            stars = Int(starsArray[1])!
        case .division:
            let starsString = divisionLevels[levelString]!
            starsArray = starsString.components(separatedBy: "_")
            stars = Int(starsArray[1])!
        case .multiplication:
            let starsString = multiplicationLevels[levelString]!
            starsArray = starsString.components(separatedBy: "_")
            stars = Int(starsArray[1])!
        case .subtraction:
            let starsString = subtractionLevels[levelString]!
            starsArray = starsString.components(separatedBy: "_")
            stars = Int(starsArray[1])!
        }
        return stars
    }
    
    func totalScore(Operator:OperatorSymbols) -> Int
    {
        var levels:[String: String] = [:]
        switch Operator {
        case .addition:
            levels = additionLevels
        case .division:
            levels = divisionLevels
        case .multiplication:
            levels = multiplicationLevels
        case .subtraction:
            levels = subtractionLevels
        }
        var totalScore = 0
        for (_, scoreStrng) in levels {
            let score = scoreStrng.components(separatedBy: "_")[0]
            totalScore = totalScore + Int(score)!
        }
        return totalScore
    }
    
    func avgStars(Operator:OperatorSymbols) -> Float
    {
        var levels:[String: String] = [:]
        switch Operator {
        case .addition:
            levels = additionLevels
        case .division:
            levels = divisionLevels
        case .multiplication:
            levels = multiplicationLevels
        case .subtraction:
            levels = subtractionLevels
        }
        var totalStars = 0
        var count = 0
        for (_, scoreStrng) in levels {
            count+=1
            let stars = scoreStrng.components(separatedBy: "_")[1]
            totalStars = totalStars + Int(stars)!
        }
        return Float(totalStars / count)
    }
}

