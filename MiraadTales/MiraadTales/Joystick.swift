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
    
    public var velocity: CGPoint
    public var direction: DirectionPlayer
    
    public var isClicked: Bool
    
    private var selectButton: SKSpriteNode!
    
    public override init() {
        
        self.leftButton = SKSpriteNode(imageNamed: "arrowLeft")
        self.leftButton.name = "LeftButton"
        self.leftButton.alpha = 0.7
        self.leftButton.xScale = 3
        self.leftButton.yScale = 3
        
        self.rightButton = SKSpriteNode(imageNamed: "arrowRight")
        self.rightButton.name = "RightButton"
        self.rightButton.alpha = 0.7
        self.rightButton.xScale = 3
        self.rightButton.yScale = 3
        
        self.upButton = SKSpriteNode(imageNamed: "arrowUp")
        self.upButton.name = "UpButton"
        self.upButton.alpha = 0.7
        self.upButton.xScale = 3
        self.upButton.yScale = 3
        
        self.downButton = SKSpriteNode(imageNamed: "arrowDown")
        self.downButton.name = "DownButton"
        self.downButton.alpha = 0.7
        self.downButton.xScale = 3
        self.downButton.yScale = 3
        
        self.velocity = CGPointZero
        
        self.direction = DirectionPlayer.None
        
        self.isClicked = false
        
        self.selectButton = nil
        
        super.init()
        
        self.name = "Joystick"
        self.xScale = 0.25
        self.yScale = 0.25
        
        let frameLeft = self.leftButton.calculateAccumulatedFrame()
        
        self.leftButton.position = CGPointMake(-frameLeft.width, 0)
        self.rightButton.position = CGPointMake(frameLeft.width, 0)
        
        let frameUp = self.upButton.calculateAccumulatedFrame()
        
        self.upButton.position = CGPointMake(0, frameUp.height)
        self.downButton.position = CGPointMake(0, -frameUp.height)
        
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
                self.selectButton.alpha = 1
                self.isClicked = true
            }
        }
    }
    
    public override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
//        for touch in touches {
//            let location = touch.locationInNode(self)
//            
//            let nodeForPosition = self.nodeAtPoint(location)
//            
//            if nodeForPosition is SKSpriteNode {
//                
//                if self.selectButton != nil && self.selectButton.name == nodeForPosition.name {
//                    selectButton.alpha = 0.7
//                    self.selectButton = nil
//                    self.isClicked = false
//                }
//            }
//        }
        
        if let selectButton = self.selectButton {
            selectButton.alpha = 0.7
            self.isClicked = false
            self.selectButton = nil
        }
    }
    
    public override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.locationInNode(self)
            
            let nodeForPosition = self.nodeAtPoint(location)
            
            if nodeForPosition is SKSpriteNode {
                
                if self.selectButton != nil && nodeForPosition.name != self.selectButton.name {
                    self.selectButton.alpha = 0.7
                    self.selectButton = nodeForPosition as! SKSpriteNode
                    self.selectButton.alpha = 1.0
                    self.isClicked = true
                }
            }
        }
    }
    
    public override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        
        if let selectButton = self.selectButton {
            selectButton.alpha = 0.7
            self.isClicked = false
        }
        self.selectButton = nil
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
