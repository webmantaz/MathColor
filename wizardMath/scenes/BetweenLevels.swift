
//
//  BetweenLevels.swift
//  mathColor
//
//  Created by James Wallace on 7/12/20.
//  Copyright © 2020 James Wallace. All rights reserved.
//

import SpriteKit

class BetweenLevels : SKScene
{
    
    var currentLevel = 1
    var symbol : OperatorSymbols
    
    override func didMove(to view: SKView) {
        let defaults = UserDefaults.standard
        self.backgroundColor = SKColor.white
        currentLevel = defaults.integer(forKey: "CurrentLevel")
        let levelCompleted = defaults.integer(forKey: "LevelCompleted")
        
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
        l.getLevel(number: levelCompleted, levelOperator: symbol)
        let levelChances = l.chances
        let levelMinToPass = l.minToPass
        
        var congrats = false
        if currentLevel == levelCompleted
        {
                congrats=true
        }
       
        
        let cheerNode = SKLabelNode()
        cheerNode.fontColor = UIColor.black
        cheerNode.fontSize = 96
        cheerNode.position = CGPoint(x: frame.midX, y: frame.midY)
        cheerNode.text = "Try Again !"
        cheerNode.name = "cheer"
        let tmpRect = CGRect(x: frame.midX-375, y: frame.maxY/3.0, width: 300, height: 100)
        let backNode = SKShapeNode(rect: tmpRect)
        backNode.fillColor = UIColor.red
        backNode.name = "back"
        self.addChild(backNode)
        if congrats == true {
            cheerNode.text = "Congratulations !"
            let tmpRect2 = CGRect(x: frame.midX+75, y: frame.maxY/3.0, width: 300, height: 100)
            let nextNode = SKShapeNode(rect: tmpRect2)
            nextNode.fillColor = UIColor.green
            nextNode.name = "next"
            
            self.addChild(nextNode)
        }
        
        self.addChild(cheerNode)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches
        {
            let loc = touch.location(in: self)
            let  actionNode = self.nodes(at: loc)
            let defaults = UserDefaults.standard
            for node in actionNode {
                if node.name! == "back"
                {
                    // go back
                    changeScene()
                }
                else if node.name! == "next"
                {
                    // next
                    currentLevel += 1
                    defaults.set(self.currentLevel, forKey: "CurrentLevel")
                    changeScene()
                }
            }
        }
    }
    
    func changeScene()
    {
        let scene = SceneIntro(fileNamed: "SceneIntro")!
        scene.scaleMode = .aspectFill
        let transition = SKTransition.moveIn(with: .right, duration: 1)
        self.view?.presentScene(scene, transition: transition)
    }
}
