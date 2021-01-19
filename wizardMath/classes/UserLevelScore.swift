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
    
    func getLevelScore(Operstor:OperatorSymbols, Level:Int) -> Int
    {
        if <#condition#> {
            <#code#>
        }
    }
}

