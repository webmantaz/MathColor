//
//  MathQuestionNode.swift
//  mathColor
//
//  Created by James Wallace on 8/15/20.
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

class MathQuestionNode : SKNode
{
    var firstNumber = 0
    var secondNumber = 0
    var operatorName : OperatorSymbols
    
    init(firstNumber: Int, secondNumber: Int, Operator: OperatorSymbols) {
        self.firstNumber = firstNumber
        self.secondNumber = secondNumber
        self.operatorName = Operator
        super.init()
        buildNode()
    }
    
    override init() {
        firstNumber = 0
        secondNumber = 0
        operatorName = OperatorSymbols.addition
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("We aren't using storyboards")
    }
    
    func buildNode()
    {
        var arrFirstNumber = [SKSpriteNode]()
        var arrSecondNumber = [SKSpriteNode]()
        let arrFn = digits(firstNumber)
        var numberOfDigitsFirstNumber = 0
        var numberOfDigitsSecondNumber = 0
        let operandImageName = getOperandImageName(operand: operatorName)
        let operandNode = SKSpriteNode(imageNamed: operandImageName)
        let operandPosition = operandNode.position
        self.addChild(operandNode)
        var pos = CGPoint()
        var digitsInFirstNumber = arrFn.count
        if firstNumber < 0 {
            digitsInFirstNumber += 1
            arrFirstNumber.insert(SKSpriteNode(imageNamed: "subtraction.png")
                        , at:numberOfDigitsFirstNumber)
            pos.x = operandPosition.x - CGFloat((70*(digitsInFirstNumber-numberOfDigitsFirstNumber)))
            pos.y = operandPosition.y
            arrFirstNumber[numberOfDigitsFirstNumber].position = pos
            self.addChild(arrFirstNumber[numberOfDigitsFirstNumber])
            numberOfDigitsFirstNumber += 1
        }
        for number in arrFn {
            arrFirstNumber.insert(SKSpriteNode(imageNamed: String(number)+".png")
                , at:numberOfDigitsFirstNumber)
            pos.x = operandPosition.x - CGFloat((70*(digitsInFirstNumber-numberOfDigitsFirstNumber)))
            pos.y = operandPosition.y
            arrFirstNumber[numberOfDigitsFirstNumber].position = pos
            self.addChild(arrFirstNumber[numberOfDigitsFirstNumber])
            numberOfDigitsFirstNumber += 1
        }
        let arrSn = digits(secondNumber)
        if secondNumber < 0
        {
            arrSecondNumber.insert(SKSpriteNode(imageNamed: "subtraction.png")
                           , at:numberOfDigitsSecondNumber)
            pos.x = operandPosition.x + CGFloat((70*(numberOfDigitsSecondNumber+1)))
            pos.y = operandPosition.y
            arrSecondNumber[numberOfDigitsSecondNumber].position = pos
            self.addChild(arrSecondNumber[numberOfDigitsSecondNumber])
            numberOfDigitsSecondNumber += 1
        }
        for number2 in arrSn {
            arrSecondNumber.insert(SKSpriteNode(imageNamed: String(number2)+".png")
                , at:numberOfDigitsSecondNumber)
            pos.x = operandPosition.x + CGFloat((70*(numberOfDigitsSecondNumber+1)))
            pos.y = operandPosition.y
            arrSecondNumber[numberOfDigitsSecondNumber].position = pos
            self.addChild(arrSecondNumber[numberOfDigitsSecondNumber])
            numberOfDigitsSecondNumber += 1
        }
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
    
    private func getOperandImageName(operand : OperatorSymbols) -> String
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
    
    private func digits(_ number: Int) -> [Int] {
        var absNumber = 0
        if number < 0
        {
            absNumber = -1 * number
        } else {
            absNumber = number
        }
        
        var num = Int(absNumber)
        var digits: [Int] = []
        while num > 0 {
            digits.insert(num % 10, at: 0)
            num /= 10
        }
        return digits
    }
        
    public func calculateResult() -> Int
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

