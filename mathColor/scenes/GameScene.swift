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
       
    var mathQuestion = SKNode()
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
    
    var attempts = 0
    var levelPassed = false
    var hats = 3
    
            
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
        
        keypadLabel.text = ""
        let initialQuestionPosition = spawnQuestion(operators: operators, numbers: numbersToUse)
        self.attempts += 1
        let barrierRect = CGRect(x: 0.0, y: 0.0, width: frame.maxX, height: 11.0)
        let barrier = SKShapeNode(rect: barrierRect)
        barrier.fillColor = UIColor.blue
        barrier.position = CGPoint(x: 0, y: frame.maxY*0.23)
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
        keypadLabel.position = CGPoint(x: 550.0, y: 100.0)
        self.addChild(keypadLabel)
        keypadLabel.fontColor = UIColor.blue
        keypadLabel.fontSize = 128
        
        scoreLabel.text = "0"
        scoreLabel.fontColor = UIColor.blue
        scoreLabel.position = CGPoint(x: frame.maxX - 200, y: frame.maxY-150)
        scoreLabel.fontSize = 96
        self.addChild(scoreLabel)
        let scoreImageNode = SKSpriteNode(imageNamed: "correct_small")
        scoreImageNode.position = CGPoint(x: scoreLabel.position.x, y: scoreLabel.position.y-70)
        self.addChild(scoreImageNode)
        missedLabel.text = "0"
        missedLabel.fontColor = UIColor.blue
        missedLabel.fontSize = 96
        missedLabel.position = CGPoint(x: frame.minX + 200, y: frame.maxY-150)
        self.addChild(missedLabel)
        let misseImagheNode = SKSpriteNode(imageNamed: "wrong_small")
        misseImagheNode.position = CGPoint(x: missedLabel.position.x, y: missedLabel.position.y-70)
        self.addChild(misseImagheNode)
        
            
        
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
                switch node.name! {
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
                        middleAlert(imageName: "wrong_big.png")
                    }
                case "backspace":
                    kpValue = editKeyPad(keyPressed: "backspace", event: kpEvent.backspace)
                    keypadLabel.text = kpLabel
                default:
                    keypadLabel.text = kpLabel
                }
            }
        }
    }
     
    func middleAlert (imageName : String)
    {
        let alertNode = SKSpriteNode(imageNamed: imageName)
        alertNode.position = CGPoint(x: frame.midX, y: frame.midY)
        self.addChild(alertNode)
        let fade = SKAction.fadeAlpha(to: 0, duration: 2)
        alertNode.run(fade)
    }
    
    func spawnQuestion(operators: [String], numbers:[Int]) -> CGPoint
    {
        let o = OperatorString()
        let fn = Int.random(in: 0 ..< numbers.count)
        let ln = Int.random(in: 0 ..< numbers.count)
        o.firstNumber = numbers[fn]
        o.secondNumber = numbers[ln]
        let op = Int.random(in: 0 ..< operators.count)
        switch operators[op] {
        case "A":
            o.operatorName = OperatorSymbols.addition
        case "S":
            o.operatorName = OperatorSymbols.subtraction
        case "M":
            o.operatorName  = OperatorSymbols.multiplication
        case "D":
            o.operatorName = OperatorSymbols.division
        default:
            o.operatorName = OperatorSymbols.addition
        }
        mathQuestion = o.buildNode()
        result = o.calculateResult()
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
            return true
        } else {
            return false
        }
    }
    
    func spawnKeypad()
    {
        var x : CGFloat
        var y : CGFloat
        let startX = CGFloat(frame.maxX * 0.12)
        for num in 0...9 {
            var tmpNode = SKSpriteNode(imageNamed: String(num)+".png")
            x=startX + CGFloat(num*90)
            y=CGFloat(frame.maxY*0.2)
            tmpNode.position = CGPoint(x: x, y: y)
            tmpNode.name = String(num)
            self.addChild(tmpNode)
        }
        let backspace = SKSpriteNode(imageNamed: "delete.png")
        backspace.position = CGPoint(x: startX+frame.maxX/2, y: CGFloat(frame.maxY*0.14))
        backspace.name = "backspace"
        self.addChild(backspace)
        let enter = SKSpriteNode(imageNamed: "enter.png")
        enter.position = CGPoint(x: startX+frame.maxX/4, y: CGFloat(frame.maxY*0.14))
        enter.name = "enter"
        self.addChild(enter)
        
    }
    
    func editKeyPad(keyPressed : String, event : kpEvent) -> Int
    {
        var valueOfKeypad = 0
        var truncatedKP = ""
        switch event {
        case .number:
            kpLabel += keyPressed
            truncatedKP = String(kpLabel.prefix(5))
            kpLabel = truncatedKP
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
            if kpLabel.isEmpty {
                valueOfKeypad = 0
            } else {
                valueOfKeypad = Int(kpLabel)!
            }
        }
        
        return valueOfKeypad
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
            
            // middleAlert(imageName: "wrong_big.png")
        }
    }
    
    func changeScene()
    {
        let scene = BetweenLevels(fileNamed: "BetweenLevels")!
        scene.scaleMode = .aspectFill
        let transition = SKTransition.moveIn(with: .right, duration: 1)
        self.view?.presentScene(scene, transition: transition)
    }
}

