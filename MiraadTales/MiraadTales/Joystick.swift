//
//  Joystick.swift
//  MiraadTales
//
//  Created by Rodolfo José on 19/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import SpriteKit

public class Joystick: SKNode {
    
    private let leftButton: SKSpriteNode
    private let rightButton: SKSpriteNode
    private let upButton: SKSpriteNode
    private let downButton: SKSpriteNode
    
    private let centerJoystick: SKSpriteNode
    
    public var velocity: CGPoint
    public var direction: DirectionPlayer
    
    public var isClicked: Bool
    
    private var selectButton: SKSpriteNode!
    
    public override init() {
        
        
        self.leftButton = SKSpriteNode(imageNamed: "controle-esquerda")
        self.leftButton.name = "LeftButton"
        self.leftButton.alpha = 0.5
        self.leftButton.xScale = 0.7
        self.leftButton.yScale = 0.7
        
        self.rightButton = SKSpriteNode(imageNamed: "controle-direita")
        self.rightButton.name = "RightButton"
        self.rightButton.alpha = 0.5
        self.rightButton.xScale = 0.7
        self.rightButton.yScale = 0.7
        
        self.upButton = SKSpriteNode(imageNamed: "controle-cima")
        self.upButton.name = "UpButton"
        self.upButton.alpha = 0.5
        self.upButton.xScale = 0.7
        self.upButton.yScale = 0.7
        
        self.downButton = SKSpriteNode(imageNamed: "controle-baixo")
        self.downButton.name = "DownButton"
        self.downButton.alpha = 0.5
        self.downButton.xScale = 0.7
        self.downButton.yScale = 0.7
        
        self.centerJoystick = SKSpriteNode(imageNamed: "bolinha")
        
        self.velocity = CGPointZero
        
        self.direction = DirectionPlayer.None
        
        self.isClicked = false
        
        self.selectButton = nil
        
        super.init()
        
        let frameLeft = self.leftButton.calculateAccumulatedFrame()
        
        self.leftButton.position = CGPointMake(-frameLeft.width / 2, 0)
        self.rightButton.position = CGPointMake(frameLeft.width / 2, 0)
        
        let frameUp = self.upButton.calculateAccumulatedFrame()
        
        self.upButton.position = CGPointMake(0, frameUp.height / 2)
        self.downButton.position = CGPointMake(0, -frameUp.height / 2)
        
        self.addChild(self.leftButton)
        self.addChild(self.rightButton)
        self.addChild(self.upButton)
        self.addChild(self.downButton)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.locationInNode(self)
            
            let nodeForPosition = self.nodeAtPoint(location)
            
            if nodeForPosition is SKSpriteNode {
                self.selectButton = nodeForPosition as! SKSpriteNode
                self.selectButton.alpha = 0.8
                self.isClicked = true
            }
        }
    }
    
    public override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let selectButton = self.selectButton {
            selectButton.alpha = 0.5
        }
        self.selectButton = nil
        self.isClicked = false
    }
    
    public override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    public override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        
        if let selectButton = self.selectButton {
            selectButton.alpha = 0.5
        }
        self.selectButton = nil
        self.isClicked = false
    }
    
    public func update(currentTime: CFTimeInterval) {
        
        if let selectButton = self.selectButton {
            
            if selectButton.name == "LeftButton" {
                self.velocity = CGPointMake(-0.99, 0)
                self.direction = DirectionPlayer.Left
            }else if selectButton.name == "RightButton" {
                self.velocity = CGPointMake(0.99, 0)
                self.direction = DirectionPlayer.Right
            }else if selectButton.name == "UpButton" {
                self.velocity = CGPointMake(0, 0.99)
                self.direction = DirectionPlayer.Up
            }else if selectButton.name == "DownButton" {
                self.velocity = CGPointMake(0, -0.99)
                self.direction = DirectionPlayer.Down
            }
        }else {
            self.velocity = CGPointZero
            self.direction = DirectionPlayer.None
        }
    }
}
