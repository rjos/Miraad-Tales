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
    public var movementManagement: MovementManagement?
    
    private var selectedButton: SKSpriteNode! = nil
    
    var interactionDelegate: InteractionDelegate? = nil
    
    public init(imageNamedButtonA: String, imageNamedButtonB: String, imageNamedButtonSwitch: String, movementManagement: MovementManagement?) {
        
        //Botão A
        self.btnAction = SKSpriteNode(imageNamed: imageNamedButtonA)
        self.btnAction.position = CGPointMake(0, 0)
        self.btnAction.alpha = 0.7
        self.btnAction.name = "btnAction"
        
        //Botão B
        self.btnBack = SKSpriteNode(imageNamed: imageNamedButtonB)
        self.btnBack.position = CGPointMake(0, self.btnAction.frame.height + 10)
        self.btnBack.alpha = 0.7
        self.btnBack.name = "btnBack"
        
        //Botão switch
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
    
    //MARK: Decode and Encode data
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Touch events
    override public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        var enableClicked = false
        var menuHasOpened = false
        
        if self.movementManagement == nil {
            enableClicked = true
        }
        
        if !enableClicked && !self.movementManagement!.player.menuHasOpened {
            menuHasOpened = true
        }
        
        if enableClicked || menuHasOpened {
            let touch = touches.first!
            
            let location = touch.locationInNode(self)
            
            let nodePosition = self.nodeAtPoint(location)
            
            if nodePosition is SKSpriteNode {
                
                nodePosition.alpha = 1
                self.selectedButton = nodePosition as! SKSpriteNode
                
                if nodePosition.name == "btnAction" {
                    print("Click em A")
                    //Interaction
                    self.interactionDelegate!.interaction()
                }else if nodePosition.name == "btnBack" {
                    
                    if !enableClicked {
                        if !self.movementManagement!.player.inCombat {
                            self.movementManagement!.player.isRunning = true
                        }
                    }
                    
                    if self.interactionDelegate != nil {
                        self.interactionDelegate!.runningDialog()
                    }
                }else if nodePosition.name == "btnSwitch" && self.enableSwitch {
                    print("Click em Switch")
                    self.switchPlayers()
                }
            }
        }
    }
    
    override public func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let selectedButton = self.selectedButton {
            selectedButton.alpha = 0.7
        }
        
        self.selectedButton = nil
        
        if self.movementManagement != nil {
            self.movementManagement!.player.isRunning = false
        }
    }
    
    override public func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        self.selectedButton = nil
        self.movementManagement!.player.isRunning = false
    }
    
    public func update(currentTime: NSTimeInterval) {
        
        if self.movementManagement != nil {
            
            //Habilitar o switch apenas quando estiver parado
            if self.movementManagement!.joystick.velocity == CGPointZero {
                self.enableSwitch = true
            }else {
                self.enableSwitch = false
            }
        }
    }
    
    //MARK: - Function for Switch players
    private func switchPlayers() {
        
        if self.enableSwitch {
            
            //Obtem a quantidade de players
            let countPlayers = self.movementManagement!.players.count
            
            //Obtem o index do player atual
            let indexCurrentPlayer = self.movementManagement!.players.indexOf(self.movementManagement!.player)!
            
            //Realiza o switch de acordo com o index do player
            if indexCurrentPlayer < countPlayers - 1 {
                self.movementManagement!.changePlayer((indexCurrentPlayer + 1))
            }else {
                self.movementManagement!.changePlayer(0)
            }
        }
    }
}
