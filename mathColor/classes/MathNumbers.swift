//
//  MathNumbers.swift
//  mathColor
//
//  Created by James Wallace on 8/15/20.
//  Copyright © 2020 James Wallace. All rights reserved.
//

enum QuestionType
{
    case numberRange
    case factor
}

enum QuestionCases {
    case allowNegative
    case allowDecimal
}

import Foundation

class MathNumbers {
    var firstNumber = 0
    var secondNumber = 0
    var questionOperator : OperatorSymbols
    var numberRange = [Int]()
    
    init() {
        self.firstNumber = 0
        self.secondNumber = 0
        self.questionOperator = OperatorSymbols.addition
        self.numberRange = []
    }
    
    init(numberRange: [Int]) {
        self.firstNumber = 0
        self.secondNumber = 0
        self.questionOperator = OperatorSymbols.addition
        self.numberRange = numberRange
    }
    
    func getDivision(questionType: QuestionType, questionCase: QuestionCases)
    {
        self.questionOperator = OperatorSymbols.division
        if questionType == QuestionType.numberRange
        {
            let fn = Int.random(in: 0 ..< numberRange.count)
            self.firstNumber = self.numberRange[fn]
            let sn = Int.random(in: 0 ..< numberRange.count)
            self.secondNumber = self.numberRange[sn]
        } else {
            arrNumbers = generateDivisionFactors(self.numberRange)
           let fn = Int.random(in: 0..<arrNumbers.count)
        }
        
    }
}
