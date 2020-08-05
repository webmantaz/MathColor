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
        titleNode.position = CGPoint(x: frame.midX+20, y: frame.midY+50)
        titleNode.text = "Wizard Math"
        self.addChild(titleNode)
    
        let additionButtonNode = SKSpriteNode(imageNamed: "addition.png")
        additionButtonNode.name = "addition"
        additionButtonNode.position = CGPoint(x: frame.minX+300
            , y: frame.midY-100)
        self.addChild(additionButtonNode)
        
        let multiplicationButtonNode = SKSpriteNode(imageNamed: "multiply.png")
        multiplicationButtonNode.name = "multiplication"
        multiplicationButtonNode.position = CGPoint(x: frame.minX+475, y: frame.midY-100)
        self.addChild(multiplicationButtonNode)
        
        let dividedButtonNode = SKSpriteNode(imageNamed: "dividedby.png")
        dividedButtonNode.name = "division"
        dividedButtonNode.position = CGPoint(x: frame.minX+650, y: frame.midY-100)
        self.addChild(dividedButtonNode)
        
        let subtractButtonNode = SKSpriteNode(imageNamed: "subtraction.png")
        subtractButtonNode.name = "subtraction"
        subtractButtonNode.position = CGPoint(x: frame.minX+825, y: frame.midY-100)
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
        
        if let purpleFire = SKEmitterNode(fileNamed: "PurpleFire") {
            purpleFire.position = multiplicationButtonNode.position
            purpleFire.zPosition = -1
            purpleFire.name = "fire"
            addChild(purpleFire)
        }
        
        if let redFire = SKEmitterNode(fileNamed: "RedFire") {
            redFire.position = additionButtonNode.position
            redFire.zPosition = -1
            redFire.name = "fire"
            addChild(redFire)
        }
        
        if let blueFire = SKEmitterNode(fileNamed: "BlueFire") {
            blueFire.position = subtractButtonNode.position
            blueFire.zPosition = -1
            blueFire.name = "fire"
            addChild(blueFire )
        }
        
        if let yellowFire = SKEmitterNode(fileNamed: "YellowFire") {
            yellowFire.position = dividedButtonNode.position
            yellowFire.zPosition = -1
            yellowFire.name = "fire"
            addChild(yellowFire)
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
        let scene = SceneIntro(fileNamed: "SceneIntro")!
        scene.scaleMode = .aspectFill
        let transition = SKTransition.moveIn(with: .right, duration: 1)
        self.view?.presentScene(scene, transition: transition)
    }
}
