//
//  SceneIntro.swift
//  mathColor
//
//  Created by James Wallace on 7/20/20.
//  Copyright © 2020 James Wallace. All rights reserved.
//

import SpriteKit

class SceneIntro : SKScene
{
    override func didMove(to view: SKView) {
    
        self.backgroundColor = UIColor.white
        
        var symbol : OperatorSymbols
        let l = MathLevel()
        let defaults = UserDefaults.standard
        let currentLevel = defaults.integer(forKey: "CurrentLevel")
        let levelOperator = defaults.string(forKey: "Operator") ?? ""
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
        
        l.getLevel(number: currentLevel, levelOperator: symbol)
        
        let levelName = l.levelName
        
        let levelNameNode = SKLabelNode()
        levelNameNode.fontColor = UIColor.black
        levelNameNode.fontSize = 96
        levelNameNode.fontName = "Impact"
        levelNameNode.position = CGPoint(x: frame.midX, y: frame.midY+400)
        levelNameNode.text = levelName
        levelNameNode.name = "leveName"
        self.addChild(levelNameNode)
        
        let startNode = SKSpriteNode(imageNamed: "nb_startlevel.png")
        startNode.position = CGPoint(x: frame.midX, y: frame.midY-200)
        startNode.name = "start"
        self.addChild(startNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches
        {
            let loc = touch.location(in: self)
            let  actionNode = self.nodes(at: loc)
            for node in actionNode
            {
                if node.name! == "start"
                {
                    changeScene()
                } else {
                    // do nothing
                }
            }
        
        }
    }
    
    func changeScene()
    {
        let scene = GameScene(fileNamed: "GameScene")!
        scene.scaleMode = .aspectFill
        let transition = SKTransition.moveIn(with: .right, duration: 1)
        self.view?.presentScene(scene, transition: transition)
        
    }
}
