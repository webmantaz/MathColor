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
    case none
    case Negative
}

import Foundation

class QuestionInfo {
    var firstNumber = 9
    var secondNumber = 0
    var questionOperator : OperatorSymbols
    var numberRange = [Int]()
    var questionType : QuestionType
    var questionCase : QuestionCases
    
    init() {
        self.firstNumber = 0
        self.secondNumber = 0
        self.questionOperator = OperatorSymbols.addition
        self.numberRange = []
        self.questionCase = QuestionCases.none
        self.questionType = QuestionType.numberRange
        getNumbers()
    }
    
    init(numberRange: [Int], questionOperator:OperatorSymbols,  questionType: QuestionType, questionCase: QuestionCases) {
        self.firstNumber = 0
        self.secondNumber = 0
        self.questionOperator = questionOperator
        self.numberRange = numberRange
        self.questionType = questionType
        self.questionCase = questionCase
        getNumbers()
    }
    
    private func getNumbers() {
        switch questionOperator {
        case OperatorSymbols.division:
            getDivision()
        case OperatorSymbols.multiplication:
            getMultiplication()
        case OperatorSymbols.addition:
            getAddition()
        case OperatorSymbols.subtraction:
            getSubtraction()
        }
    }
    
    private func getMultiplication()
    {
        self.questionOperator = OperatorSymbols.multiplication
        if questionType == QuestionType.numberRange
        {
            let fn = Int.random(in: 0..<numberRange.count)
            self.firstNumber = numberRange[fn]
            let sn = Int.random(in: 0..<numberRange.count)
            self.secondNumber = numberRange[sn]
        } else if questionType == QuestionType.factor
        {
            self.firstNumber = Int.random(in: 1...12)
            let positionInNumberRange = Int.random(in: 0..<numberRange.count)
            self.secondNumber = numberRange[positionInNumberRange]
        }
        
    }
    
    private func getAddition() {
        let fn = Int.random(in: 0..<numberRange.count)
        self.firstNumber = numberRange[fn]
        let sn = Int.random(in: 0..<numberRange.count)
        self.secondNumber = numberRange[sn]
    }
    
    private func getSubtraction()
    {
        let fn = Int.random(in: 0..<numberRange.count)
        self.firstNumber = numberRange[fn]
        let sn = Int.random(in: 0..<numberRange.count)
        self.secondNumber = numberRange[sn]
        while self.firstNumber - self.secondNumber < 0 {
            let sn = Int.random(in: 0..<numberRange.count)
            self.secondNumber = numberRange[sn]
        }
                        
    }
    
    private func getDivision()
    {
        self.questionOperator = OperatorSymbols.division
        if questionType == QuestionType.numberRange
        {
            let fn = Int.random(in: 0 ..< numberRange.count)
            self.firstNumber = self.numberRange[fn]
            let sn = Int.random(in: 0 ..< numberRange.count)
            self.secondNumber = self.numberRange[sn]
        } else if questionType == QuestionType.factor {
            let arrNumbers = generateDivisionFactors(numberRange: self.numberRange)
            let randomPosition = Int.random(in: 0..<arrNumbers.count)
            let fraction = arrNumbers[randomPosition]
            self.firstNumber =  fraction.numerator
            self.secondNumber = fraction.denominator
        }
        
    }
    
    private func generateDivisionFactors(numberRange: [Int]) -> [Fraction] {
        var tmpFraction = Fraction()
        var arrFractions = [Fraction]()
        
        for denominator in numberRange {
            for numerator in 1...12 {
                tmpFraction.numerator = numerator*denominator
                tmpFraction.denominator = denominator
                arrFractions.append(tmpFraction)
            }
        }
        
        return arrFractions
    }
}
