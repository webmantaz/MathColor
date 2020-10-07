
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
    
    override func didMove(to view: SKView) {
        var symbol : OperatorSymbols
                
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
        let levelScore = defaults.integer(forKey: "levelScore")
        
        var stars = 0
        
        if congrats == true && levelScore > 0 {
            let scoreDiff = levelChances - levelMinToPass
            let scoreDiffSection = Double(scoreDiff) / 3.0
            let minimumRange = Double(levelMinToPass) + scoreDiffSection
            
            if Double(levelScore) < minimumRange
            {
                stars = 1
            } else if Double(levelScore) < minimumRange+scoreDiffSection
            {
                stars = 2 
            } else {
                stars = 3
            }
        }
        
        let cheerNode = SKLabelNode()
        cheerNode.position = CGPoint(x: frame.midX, y: frame.midY)
        cheerNode.fontSize = 96
        cheerNode.fontColor = UIColor.black
        cheerNode.text = "Try Again"
        cheerNode.name = "cheer"
        cheerNode.zPosition = 100
        
        self.addChild(cheerNode)
        
        let backNode = SKSpriteNode(imageNamed: "nb_replaylevel.png")
        backNode.position = CGPoint(x: frame.maxX*0.3, y: frame.maxY/3.0)
        backNode.name = "back"
        self.addChild(backNode)
        if congrats == true {
            cheerNode.isHidden = true
            let starNode = MultiImageNode(imageName: "star.png", numberOfImages: stars)
            starNode.position = CGPoint(x: frame.maxX*0.3, y: frame.midY)
            starNode.name = "star"
            self.addChild(starNode)
            let nextNode = SKSpriteNode(imageNamed: "nb_nextlevel.png")
            nextNode.position = CGPoint(x: frame.maxX*0.7, y: frame.maxY/3.0)
            nextNode.name = "next"
            self.addChild(nextNode)
        }
        
        
        
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
                } else {
                // do nothing
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
