//
//  ActionManagement.swift
//  MiraadTales
//
//  Created by Rodolfo José on 17/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import SpriteKit

public class ActionManagement: SKNode {

    public var btnAction: SKSpriteNode
    public var btnBack: SKSpriteNode
    public var btnSwitch: SKSpriteNode
    
    public var enableSwitch: Bool
    public var movementManagement: MovementManagement
    
    private var selectedButton: SKSpriteNode! = nil
    
    public init(imageNamedButtonA: String, imageNamedButtonB: String, imageNamedButtonSwitch: String, movementManagement: MovementManagement) {
        
        self.btnAction = SKSpriteNode(imageNamed: imageNamedButtonA)
        self.btnAction.position = CGPointMake(0, 0)
        self.btnAction.alpha = 0.7
        self.btnAction.name = "btnAction"
        
        self.btnBack = SKSpriteNode(imageNamed: imageNamedButtonB)
        self.btnBack.position = CGPointMake(0, self.btnAction.frame.height + 10)
        self.btnBack.alpha = 0.7
        self.btnBack.name = "btnBack"
        
        self.btnSwitch = SKSpriteNode(imageNamed: imageNamedButtonSwitch)
        self.btnSwitch.position = CGPointMake(0, self.btnBack.frame.height + self.btnBack.position.y + 10)
        self.btnSwitch.alpha = 0.7
        self.btnSwitch.name = "btnSwitch"
        
        self.enableSwitch = false
        
        self.movementManagement = movementManagement
        
        super.init()
        
        self.addChild(self.btnAction)
        self.addChild(self.btnBack)
        self.addChild(self.btnSwitch)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Touch events
    override public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if !self.movementManagement.player.menuHasOpened {
            let touch = touches.first!
            
            let location = touch.locationInNode(self)
            
            let nodePosition = self.nodeAtPoint(location)
            
            if nodePosition is SKSpriteNode {
                
                nodePosition.alpha = 1
                self.selectedButton = nodePosition as! SKSpriteNode
                
                if nodePosition.name == "btnAction" {
                    print("Click em A")
                }else if nodePosition.name == "btnBack" {
                    if !self.movementManagement.player.inCombat {
                        self.movementManagement.player.isRunning = true
                    }
                }else if nodePosition.name == "btnSwitch" && self.enableSwitch {
                    print("Click em Switch")
                    self.switchPlayers()
                }
            }
        }
    }
    
    override public func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
//        for touch in touches {
//            
//            let location = touch.locationInNode(self)
//            
//            let nodeForPosition = self.nodeAtPoint(location)
//            
//            if nodeForPosition is SKSpriteNode && !self.movementManagement.player.menuHasOpened {
//                
//                if self.selectedButton != nil && self.selectedButton.name == nodeForPosition.name {
//                    self.selectedButton.alpha = 0.7
//                    self.selectedButton = nil
//                }
//            }
//        }
        
        if let selectedButton = self.selectedButton {
            selectedButton.alpha = 0.7
        }
        
        self.selectedButton = nil
        self.movementManagement.player.isRunning = false
        
//        if !self.movementManagement.player.menuHasOpened {
//            let touch = touches.first!
//            
//            let location = touch.locationInNode(self)
//            
//            let nodePosition = self.nodeAtPoint(location)
//            
//            if nodePosition is SKSpriteNode {
//                //Caso queira realizar alguma ação
//            }
//            
//            if self.selectedButton != nil {
//            }
//        }
    }
    
    override public func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        self.selectedButton = nil
        self.movementManagement.player.isRunning = false
    }
    
    public func update(currentTime: NSTimeInterval) {
        
        if self.movementManagement.josytick.velocity == CGPointZero {
            self.enableSwitch = true
        }else {
            self.enableSwitch = false
        }
        
    }
    
    //MARK: - Function for Switch players
    private func switchPlayers() {
        
        if self.enableSwitch {
            
            let countPlayers = self.movementManagement.players.count
            var indexCurrentPlayer = self.movementManagement.players.indexOf(self.movementManagement.player)!
            
            if indexCurrentPlayer < countPlayers - 1 {
                self.movementManagement.changePlayer((indexCurrentPlayer + 1))
            }else {
                self.movementManagement.changePlayer(0)
            }
        }
    }
}
