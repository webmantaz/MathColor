//
//  GameScene.swift
//  mathColor
//
//  Created by James Wallace on 6/27/20.
//  Copyright © 2020 James Wallace. All rights reserved.
//

enum kpEvent {
    case number
    case enter
    case backspace
    case negative
}

enum operatorEvent {
    case divide
    case multiply
    case add
    case subtract
    case random
}

import SpriteKit

enum CollisinType : UInt32 {
    case question = 1
    case barrier = 2
}


class GameScene: SKScene, SKPhysicsContactDelegate {
       
    var mathQuestion = MathQuestionNode()
    var keypadLabel = SKLabelNode()
    var scoreLabel = SKLabelNode()
    var missedLabel = SKLabelNode()
    var kpLabel = ""
    var kpValue = 0
    var result = 0
    var respawn = false
    var score = 0
    var missed = 0
    var showCorrect = false
    var showWrong = false
    
    var levelName = ""
    var levelNumber = 1
    var operators = ["A"]
    var numbersToUse = [1]
    var chances = 0
    var minToPass = 0
    var timeToFall = 0.0
    var levelType = ""
    var levelCase = ""
    
    var attempts = 0
    var levelPassed = false
    var hats = 3
    
    var triesYPosition = CGFloat()
    var triesNode = MultiImageNode()
    
    

    
    
    
    override func didMove(to view: SKView) {
        
        var symbol : OperatorSymbols
        
        physicsWorld.contactDelegate = self
        
        let defaults = UserDefaults.standard
        levelNumber = defaults.integer(forKey: "CurrentLevel")
        let levelOperator = defaults.string(forKey: "Operator")
        let l = MathLevel()
        switch levelOperator {
        case "A":
            symbol = OperatorSymbols.addition
        case "M":
            symbol = OperatorSymbols.multiplication
        case "S":
            symbol = OperatorSymbols.subtraction
        case "D":
            symbol = OperatorSymbols.division
        default:
            symbol = OperatorSymbols.addition
        }
        l.getLevel(number: levelNumber, levelOperator: symbol)
        defaults.set(l.levelNumber, forKey: "CurrentLevel")

        levelName = l.levelName
        operators = l.operators
        numbersToUse = l.numbersToUse
        timeToFall = l.timeToFall
        chances = l.chances
        minToPass = l.minToPass
        levelNumber = l.levelNumber
        levelType = l.levelType
        levelCase = l.levelCase
        keypadLabel.text = ""
        let initialQuestionPosition = spawnQuestion(operators: operators, numbers: numbersToUse)
        self.attempts += 1
        let barrierRect = CGRect(x: 0.0, y: 0.0, width: frame.maxX, height: 11.0)
        let barrier = SKShapeNode(rect: barrierRect)
        barrier.fillColor = UIColor.blue
        barrier.position = CGPoint(x: 0, y: frame.maxY*0.26)
        barrier.name = "barrier"
        let barrierPhysicsBodySize = CGSize(width: frame.maxX, height: 30.0)
        barrier.physicsBody = SKPhysicsBody(rectangleOf: barrierPhysicsBodySize)
        barrier.physicsBody?.isDynamic = false
        barrier.physicsBody?.categoryBitMask = CollisinType.barrier.rawValue
        
        self.addChild(barrier)
        
        let t=timeToFall
        let ppm = 150.0
        let distanceFromQuestionToBarrier = GetDistance(from: initialQuestionPosition, to: barrier.position)
        let deltaGravity = ((2.0 * Double(distanceFromQuestionToBarrier))/(t*t*ppm))
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -1*deltaGravity)
        
        spawnKeypad()
        
        scoreLabel.text = "0"
        scoreLabel.fontColor = UIColor.blue
        scoreLabel.position = CGPoint(x: frame.maxX - 200, y: frame.maxY-150)
        scoreLabel.fontSize = 96
        scoreLabel.name = "scoreKabel"
        self.addChild(scoreLabel)
        let scoreImageNode = SKSpriteNode(imageNamed: "correct_small")
        scoreImageNode.position = CGPoint(x: scoreLabel.position.x, y: scoreLabel.position.y-70)
        scoreImageNode.name = "scoreImage"
        self.addChild(scoreImageNode)
        missedLabel.text = "0"
        missedLabel.name = "missedLabel"
        missedLabel.fontColor = UIColor.blue
        missedLabel.fontSize = 96
        missedLabel.position = CGPoint(x: frame.minX + 200, y: frame.maxY-150)
        self.addChild(missedLabel)
        let missedImageNode = SKSpriteNode(imageNamed: "wrong_small")
        missedImageNode.position = CGPoint(x: missedLabel.position.x, y: missedLabel.position.y-70)
        missedImageNode.name = "missedImage"
        self.addChild(missedImageNode)
        redrawLives(yPosition: scoreImageNode.position.y)
        triesYPosition = scoreImageNode.position.y
    }
    
    func CGPointDistanceSquared(from: CGPoint, to: CGPoint) -> CGFloat {
        return (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
    }

    func GetDistance(from: CGPoint, to: CGPoint) -> CGFloat {
        return sqrt(CGPointDistanceSquared(from: from, to: to))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for touch in touches
        {
            let loc = touch.location(in: self)
            let kpNode = self.nodes(at: loc)
            for node in kpNode {
                switch node.name {
                case "0":
                    kpValue = editKeyPad(keyPressed: "0", event: kpEvent.number)
                    if kpValue == 0
                    {
                        keypadLabel.text = ""
                        kpLabel = ""
                    } else {
                        keypadLabel.text = kpLabel
                    }
                case "1":
                    kpValue = editKeyPad(keyPressed: "1", event: kpEvent.number)
                    keypadLabel.text = kpLabel
                case "2":
                    kpValue = editKeyPad(keyPressed: "2", event: kpEvent.number)
                    keypadLabel.text = kpLabel
                case "3":
                    kpValue = editKeyPad(keyPressed: "3", event: kpEvent.number)
                    keypadLabel.text = kpLabel
                case "4":
                    kpValue = editKeyPad(keyPressed: "4", event: kpEvent.number)
                    keypadLabel.text = kpLabel
                case "5":
                    kpValue = editKeyPad(keyPressed: "5", event: kpEvent.number)
                    keypadLabel.text = kpLabel
                case "6":
                    kpValue = editKeyPad(keyPressed: "6", event: kpEvent.number)
                    keypadLabel.text = kpLabel
                case "7":
                    kpValue = editKeyPad(keyPressed: "7", event: kpEvent.number)
                    keypadLabel.text = kpLabel
                case "8":
                    kpValue = editKeyPad(keyPressed: "8", event: kpEvent.number)
                    keypadLabel.text = kpLabel
                case "9":
                    kpValue = editKeyPad(keyPressed: "9", event: kpEvent.number)
                    keypadLabel.text = kpLabel
                case "enter":
                    kpValue = editKeyPad(keyPressed: "9", event: kpEvent.enter)
                    if checkResult() == true
                    {
                        keypadLabel.text = ""
                        kpLabel = ""
                        if let sparkle = SKEmitterNode(fileNamed: "Sparkle") {
                            sparkle.position = mathQuestion.position
                            sparkle.name = "sparkle"
                            self.addChild(sparkle)
                        }
                        mathQuestion.removeFromParent()
                        respawn = true
                        // middleAlert(imageName: "correct_big.png")
                    } else {
                        keypadLabel.text = kpLabel
                        redrawLives(yPosition: triesYPosition)                    }
                case "backspace":
                    kpValue = editKeyPad(keyPressed: "backspace", event: kpEvent.backspace)
                    keypadLabel.text = kpLabel
                case "negative":
                    kpValue = editKeyPad(keyPressed: "-", event: kpEvent.negative)
                    keypadLabel.text = kpLabel
                default:
                    keypadLabel.text = kpLabel
                }
            }
        }
    }
     
    
    func spawnQuestion(operators: [String], numbers:[Int]) -> CGPoint
    {
         
        var operatorName = OperatorSymbols.addition
        let op = Int.random(in: 0 ..< operators.count)
        switch operators[op] {
        case "A":
            operatorName = OperatorSymbols.addition
        case "S":
            operatorName = OperatorSymbols.subtraction
        case "M":
            operatorName  = OperatorSymbols.multiplication
        case "D":
            operatorName = OperatorSymbols.division
        default:
            operatorName = OperatorSymbols.addition
        }
        var questionType : QuestionType
        if self.levelType == "Factor"
        {
            questionType = QuestionType.factor
        } else {
            questionType = QuestionType.numberRange
        }
        let questionInfo = QuestionInfo(numberRange: numbers, questionOperator: operatorName, questionType: questionType, questionCase: QuestionCases.none)
        mathQuestion = MathQuestionNode(firstNumber: questionInfo.firstNumber, secondNumber: questionInfo.secondNumber, Operator: questionInfo.questionOperator)
        mathQuestion.name = "mq"
        result = mathQuestion.calculateResult()
        let numberOfNodesInMathQuestion = mathQuestion.children.count
        let xsize = CGFloat(70 * numberOfNodesInMathQuestion)
        let size = CGSize(width: xsize, height: 70.0)
        mathQuestion.physicsBody = SKPhysicsBody(rectangleOf: size)
        mathQuestion.position = CGPoint(x: frame.midX, y: frame.maxY*0.8)
        let initalPosition = mathQuestion.position
        mathQuestion.physicsBody?.categoryBitMask = CollisinType.question.rawValue
        mathQuestion.physicsBody?.isDynamic = true
        mathQuestion.physicsBody?.collisionBitMask = CollisinType.barrier.rawValue
        mathQuestion.physicsBody?.contactTestBitMask = CollisinType.barrier.rawValue
        self.addChild(mathQuestion)
        
        return initalPosition
        
        
    }
    
    func checkResult() -> Bool
    {
        if kpValue == result
        {
            score += 1
            hats=3
            redrawLives(yPosition: triesYPosition)
            return true
        } else {
            if hats-1 == 0
            {
                if let boomFire = SKEmitterNode(fileNamed: "BoomFire") {
                               boomFire.position = mathQuestion.position
                               boomFire.zPosition = -1
                               addChild(boomFire)
                           }
                           mathQuestion.removeFromParent()
                           respawn = true
                           missed += 1
                           keypadLabel.text = ""
                           kpLabel = ""
                           hats=3
            } else {
                hats -= 1
            }
            return false
        }
    }
    
    func spawnKeypad()
    {
        var x : CGFloat
        var y : CGFloat
        let startX = frame.maxY * 0.05
        let startY = frame.maxY*0.18
        var currentRow = 0
        var currentItem = 1
        var num = 9
        repeat {
            if (num % 3 == 0)
            {
                currentRow += 1
                currentItem = 4
            }
            currentItem -= 1
            x=startX + CGFloat(120*currentItem)
            y=startY - CGFloat((currentRow-1) * 120)
            var tmpNode = SKSpriteNode(imageNamed: "bb_"+String(num)+".png")
            tmpNode.position = CGPoint(x: x, y: y)
            tmpNode.name = String(num)
            self.addChild(tmpNode)
            num -= 1
        } while num > 0
        let zero = SKSpriteNode(imageNamed: "bb_0.png")
        zero.position = CGPoint(x: startX+(4*120), y: startY)
        zero.name = "0"
        self.addChild(zero)
        let backspace = SKSpriteNode(imageNamed: "bb_backspace.png")
        backspace.position = CGPoint(x: startX+(5*120), y: startY)
        backspace.name = "backspace"
        self.addChild(backspace)
        let enter = SKSpriteNode(imageNamed: "bb_enter.png")
        enter.position = CGPoint(x: startX+(5*120), y: startY - 180)
        enter.name = "enter"
        self.addChild(enter)
        if levelCase == "Negative" {
            let negative = SKSpriteNode(imageNamed: "bb_negative.png")
            negative.name = "negative"
            negative.position = CGPoint(x: startX+(4*120), y: startY-120)
            self.addChild(negative)
        }
        keypadLabel.position = CGPoint(x: frame.midX, y: startY+70)
        keypadLabel.fontColor = UIColor.black
        keypadLabel.fontSize = 96
        keypadLabel.name = "keyPadLabel"
        keypadLabel.fontName = "impact"
        self.addChild(keypadLabel)
    }
    
    func editKeyPad(keyPressed : String, event : kpEvent) -> Int
    {
        var valueOfKeypad = 0
        var truncatedKP = ""
        switch event {
        case .number:
            kpLabel += keyPressed
            truncateLabel(maxDigits: 4)
            valueOfKeypad = Int(kpLabel)!
        case .backspace:
            let lengthOFKeypadLabel = kpLabel.count
            if lengthOFKeypadLabel == 0
            {
                truncatedKP = ""
            } else {
                truncatedKP = String(kpLabel.prefix(lengthOFKeypadLabel - 1))
            }
            kpLabel = truncatedKP
        case .enter:
            if kpLabel.isEmpty || kpLabel == "-" {
                valueOfKeypad = 0
            } else {
                valueOfKeypad = Int(kpLabel)!
            }
        case .negative:
            if kpLabel.prefix(1) == "-" {
                let sizeOfKpLabel = kpLabel.count
                kpLabel = String(kpLabel.suffix(sizeOfKpLabel-1))
            } else {
                kpLabel = "-" + kpLabel
            }
            let truncKP = kpLabel.prefix(5)
            kpLabel = String(truncKP)
            if kpLabel == "-" {
                valueOfKeypad = 0
            } else {
                if kpLabel.isEmpty {
                    valueOfKeypad = 0
                } else {
                    valueOfKeypad = Int(kpLabel)!
                }
                
            }
        }
        
        
        
        return valueOfKeypad
        
    }
    
    func truncateLabel(maxDigits: Int)
    {
        var isNegative = false
        var numberOfDigits = 0
        var numberOfDescribers = 0
        var truncated = ""
        var digits = ""
                     
        if kpLabel.prefix(1) == "-"
        {
            isNegative = true
            numberOfDescribers += 1
        }
        numberOfDigits = kpLabel.count - numberOfDescribers
        
        if isNegative {
            if numberOfDigits > maxDigits
            {
                digits = String(kpLabel.suffix(maxDigits))
                kpLabel = "-" + digits
            } else {
                digits = String(kpLabel.suffix(numberOfDigits))
                kpLabel = "-" + digits
            }
        } else {
            truncated = String(kpLabel.prefix(maxDigits))
            kpLabel = truncated
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if respawn == true
        {
            if attempts < chances
            {
                spawnQuestion(operators: operators, numbers: numbersToUse)
                self.attempts += 1
                respawn = false
            } else {
                respawn = false
                if score >= minToPass
                {
                    levelPassed = true
                    let defaults = UserDefaults.standard
                    defaults.set(self.levelNumber, forKey: "LevelCompleted")
                    defaults.set(score, forKey: "levelScore")
                    changeScene()
                } else {
                    levelPassed = false
                    let defaults = UserDefaults.standard
                    defaults.set(self.levelNumber-1, forKey: "LevelCompleted")
                    changeScene()
                }
            }
        }
        scoreLabel.text = String(score)
        missedLabel.text = String(missed)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else {return}
        
        if nodeB.name == "barrier"
        {
            
            if let boomFire = SKEmitterNode(fileNamed: "BoomFire") {
                boomFire.position = nodeA.position
                boomFire.zPosition = -1
                addChild(boomFire)
            }
            nodeA.removeFromParent()
            respawn = true
            missed += 1
            keypadLabel.text = ""
            kpLabel = ""
            hats = 3
            redrawLives(yPosition: triesYPosition)
            
            // middleAlert(imageName: "wrong_big.png")
        }
    }
    
    func redrawLives(yPosition : CGFloat)
    {
        triesNode.removeFromParent()
        triesNode = MultiImageNode(imageName: "magicianHat", numberOfImages: hats)
        triesNode.position = CGPoint(x: frame.midX-80, y: yPosition)
        self.addChild(triesNode)
    }
    
    func changeScene()
    {
        let scene = BetweenLevels(fileNamed: "BetweenLevels")!
        scene.scaleMode = .aspectFill
        let transition = SKTransition.moveIn(with: .right, duration: 1)
        self.view?.presentScene(scene, transition: transition)
    }
}

