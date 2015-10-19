//
//  Joystick.swift
//  MiraadTales
//
//  Created by Rodolfo José on 19/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import SpriteKit

public class Joystick: SKNode {
    
    private let leftButton: Button
    private let rightButton: Button
    private let upButton: Button
    private let downButton: Button
    
    private let centerJoystick: SKSpriteNode
    
    public var velocity: CGPoint
    public var direction: DirectionPlayer
    
    public var isClicked: Bool
    
    private var selectButton: Button!
    
    public override init() {
        
        self.leftButton = Button(backgroundImage: "esquerda", itemImage: "esquerda2")
        self.leftButton.name = "LeftButton"
        self.leftButton.position = CGPointMake(-self.leftButton.frame.width / 2, 0)
        
        self.rightButton = Button(backgroundImage: "direita", itemImage: "direita2")
        self.rightButton.name = "RightButton"
        self.rightButton.position = CGPointMake(self.rightButton.frame.width / 2, 0)
        
        self.upButton = Button(backgroundImage: "cima", itemImage: "cima2")
        self.upButton.name = "UpButton"
        self.upButton.position = CGPointMake(0, self.upButton.frame.height / 2)
        
        self.downButton = Button(backgroundImage: "baixo", itemImage: "baixo2")
        self.downButton.name = "DownButton"
        self.downButton.position = CGPointMake(0, -self.downButton.frame.height / 2)
        
        self.centerJoystick = SKSpriteNode(imageNamed: "bolinha")
        
        self.velocity = CGPointZero
        
        self.direction = DirectionPlayer.None
        
        self.isClicked = false
        
        self.selectButton = nil
        
        super.init()
        
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
            
            if nodeForPosition is Button {
                
                nodeForPosition.touchesBegan(touches, withEvent: event)
                self.selectButton = (nodeForPosition as! Button)
                self.isClicked = true
            }
        }
    }
    
    public override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let selectButton = self.selectButton {
            selectButton.touchesEnded(touches, withEvent: event)
        }
        
        self.isClicked = false
    }
    
    public override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.locationInNode(self)
            
            let nodeForPosition = self.nodeAtPoint(location)
            
            if nodeForPosition is Button && nodeForPosition != self.selectButton {
             
                nodeForPosition.touchesBegan(touches, withEvent: event)
                self.selectButton = (nodeForPosition as! Button)
            }
        }
        
    }
    
    public override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        
        if let selectButton = self.selectButton {
            selectButton.touchesEnded(touches!, withEvent: event)
        }
        
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
