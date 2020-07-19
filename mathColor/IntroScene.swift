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
        additionButtonNode.position = CGPoint(x: frame.minX+100, y: frame.midY-100)
        self.addChild(additionButtonNode)
        
        let multiplicationButtonNode = SKSpriteNode(imageNamed: "multiply.png")
        multiplicationButtonNode.name = "multiplication"
        multiplicationButtonNode.position = CGPoint(x: frame.minX+300, y: frame.midY-100)
        self.addChild(multiplicationButtonNode)
        
        let dividedButtonNode = SKSpriteNode(imageNamed: "dividedby.png")
        dividedButtonNode.name = "multiplication"
        dividedButtonNode.position = CGPoint(x: frame.minX+500, y: frame.midY-100)
        self.addChild(dividedButtonNode)
        
         
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches
        {
            let loc = touch.location(in: self)
            let  actionNode = self.nodes(at: loc)
            for node in actionNode {
                if node.name! == "start"
                {
                    // go back
                    changeScene()
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
