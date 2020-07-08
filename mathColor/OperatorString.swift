//
//  OperatorString.swift
//  mathColor
//
//  Created by James Wallace on 6/27/20.
//  Copyright © 2020 James Wallace. All rights reserved.
//

import Foundation
import SpriteKit

enum OperatorSymbols : String {
    case addition = "plus.png"
    case subtraction = "subtraction.png"
    case division = "divideby.png"
    case multiplication = "multiply.png"
}

class OperatorString
{
    var firstNumber = 0
    var secondNumber = 0
    var operatorName : OperatorSymbols
    
    init() {
        firstNumber = 0
        secondNumber = 0
        operatorName = OperatorSymbols.addition
    }
      
    func buildNode() -> SKNode
    {
        let factQuestion : SKNode
        factQuestion = SKNode()
        var arrFirstNumber = [SKSpriteNode]()
        var arrSecondNumber = [SKSpriteNode]()
        let arrFn = digits(firstNumber)
        var numberOfDigitsFirstNumber = 0
        var numberOfDigitsSecondNumber = 0
        let operandImageName = getOperandImageName(operand: operatorName)
        let operandNode = SKSpriteNode(imageNamed: operandImageName)
        let operandPosition = operandNode.position
        factQuestion.addChild(operandNode)
        var pos = CGPoint()
        let digitsInFirstNumber = arrFn.count
        for number in arrFn {
            
            arrFirstNumber.insert(SKSpriteNode(imageNamed: String(number)+".png")
                , at:numberOfDigitsFirstNumber)
            pos.x = operandPosition.x - CGFloat((70*(digitsInFirstNumber-numberOfDigitsFirstNumber)))
            pos.y = operandPosition.y
            arrFirstNumber[numberOfDigitsFirstNumber].position = pos
            factQuestion.addChild(arrFirstNumber[numberOfDigitsFirstNumber])
            numberOfDigitsFirstNumber += 1
        }
        let arrSn = digits(secondNumber)
        for number2 in arrSn {
            arrSecondNumber.insert(SKSpriteNode(imageNamed: String(number2)+".png")
                , at:numberOfDigitsSecondNumber)
            pos.x = operandPosition.x + CGFloat((70*(numberOfDigitsSecondNumber+1)))
            pos.y = operandPosition.y
            arrSecondNumber[numberOfDigitsSecondNumber].position = pos
            factQuestion.addChild(arrSecondNumber[numberOfDigitsSecondNumber])
            numberOfDigitsSecondNumber += 1
        }
        return factQuestion
    }

    func digits(number : Int) -> [Int] {
        var num = number
        var digits : [Int] = []
        while num > 0 {
            digits.insert(num % 10, at: 0)
            num /= 10
        }
        return digits
    }
    
    func getOperandImageName(operand : OperatorSymbols) -> String
    {
        var imageName = ""
        switch operand {
        case OperatorSymbols.addition:
            imageName = "addition.png"
        case OperatorSymbols.multiplication:
            imageName = "multiply.png"
        case OperatorSymbols.division:
            imageName = "dividedby.png"
        case OperatorSymbols.subtraction:
            imageName = "subtraction.png"
        default:
            imageName = "addition.png"
        }
        return imageName
    }
    
    func digits(_ number: Int) -> [Int] {
        var number = number
        var digits: [Int] = []
        while number > 0 {
            digits.insert(number % 10, at: 0)
            number /= 10
        }
        return digits
    }
    
    func calculateResult() -> Int
    {
        var result = 0
        
        switch self.operatorName {
        case OperatorSymbols.addition:
            result = self.firstNumber + self.secondNumber
        case OperatorSymbols.subtraction:
            result = self.firstNumber - self.secondNumber
        case OperatorSymbols.division:
            result = self.firstNumber / self.secondNumber
        case OperatorSymbols.multiplication:
            result = self.firstNumber * self.secondNumber
        }
    return result
    }
    
    
}

