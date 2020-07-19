//
//  IntroScene.swift
//  mathColor
//
//  Created by James Wallace on 7/18/20.
//  Copyright © 2020 James Wallace. All rights reserved.
//

import SpriteKit

class IntroScene : SKScene
{
    override func didMove(to view: SKView)
    {
        
        
        self.backgroundColor = SKColor.white
        let titleNode = SKLabelNode()
        titleNode.fontSize = 96
        titleNode.zPosition = 10
        titleNode.fontColor = UIColor.black
        titleNode.position = CGPoint(x: frame.midX, y: frame.midY)
        titleNode.text = "Wizard Math"
        self.addChild(titleNode)
    
        let additionButtonNode = SKSpriteNode(imageNamed: "addition.png")
        additionButtonNode.name = "addition"
        additionButtonNode.position = CGPoint(x: frame.minX+150, y: frame.midY-100)
        self.addChild(additionButtonNode)
        
        let multiplicationButtonNode = SKSpriteNode(imageNamed: "multiply.png")
        multiplicationButtonNode.name = "multiplication"
        multiplicationButtonNode.position = CGPoint(x: frame.minX+300, y: frame.midY-100)
        self.addChild(multiplicationButtonNode)
        
        let dividedButtonNode = SKSpriteNode(imageNamed: "dividedby.png")
        dividedButtonNode.name = "division"
        dividedButtonNode.position = CGPoint(x: frame.minX+450, y: frame.midY-100)
        self.addChild(dividedButtonNode)
        
        let subtractButtonNode = SKSpriteNode(imageNamed: "subtraction.png")
        subtractButtonNode.name = "subtraction"
        subtractButtonNode.position = CGPoint(x: frame.minX+575, y: frame.midY-100)
        self.addChild(subtractButtonNode)
        
        let button = CGRect(x: frame.midX-150, y: frame.midY-300, width: 300, height: 100)
        let continueNode = SKShapeNode(rect: button)
        continueNode.fillColor = UIColor.yellow
        continueNode.name = "continue"
        continueNode.isHidden = true
        self.addChild(continueNode)
        
        let defaults = UserDefaults.standard
        let levelOperator = defaults.string(forKey: "Operator") ?? ""
        let operators : Set = ["A","S","M","D"]
        if operators.contains(levelOperator)
        {
            // display continue button
            continueNode.isHidden = false
        }
        
        
        
        
         
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches
        {
            let loc = touch.location(in: self)
            let  actionNode = self.nodes(at: loc)
            let defailts = UserDefaults.standard
            for node in actionNode {
                switch node.name! {
                case "continue":
                    changeScene()
                case "addition":
                    defailts.set(1, forKey: "CurrentLevel")
                    defailts.set(1, forKey: "LevelCompleted")
                    defailts.set("A", forKey: "Operator")
                    changeScene()
                case "multiplication":
                    defailts.set(1, forKey: "CurrentLevel")
                    defailts.set(1, forKey: "LevelCompleted")
                    defailts.set("M", forKey: "Operator")
                    changeScene()
                case "subtraction":
                    defailts.set(1, forKey: "CurrentLevel")
                    defailts.set(1, forKey: "LevelCompleted")
                    defailts.set("S", forKey: "Operator")
                    changeScene()
                case "division":
                    defailts.set(1, forKey: "CurrentLevel")
                    defailts.set(1, forKey: "LevelCompleted")
                    defailts.set("D", forKey: "Operator")
                    changeScene()

                    
                default:
                     print("default")
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
