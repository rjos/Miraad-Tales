//
//  CastleScene.swift
//  MiraadTales
//
//  Created by Rodolfo José on 24/11/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import SpriteKit

class CastleScene: SKScene, InteractionDelegate {

    var joystick: Joystick!
    var actionManagement: ActionManagement!
    var movementManagement: MovementManagement!
    var players: [Player]!
    var currentPlayer: Player!
    var map: SKNode!
    
    override func didMoveToView(view: SKView) {
        
        map = self.childNodeWithName("SKBg")!
        
        let skJoystick = self.camera!.childNodeWithName("SKJoystick")!
        let skButtons = self.camera!.childNodeWithName("SKButtons")!
        
        self.joystick = Joystick()
        
        self.movementManagement = MovementManagement(player: self.currentPlayer!, camera: self.camera!, sizeMap: self.map!.frame, joystick: self.joystick!, players: self.players)
        
        self.actionManagement = ActionManagement(imageNamedButtonA: "A", imageNamedButtonB: "B", imageNamedButtonSwitch: "switch", movementManagement: self.movementManagement)
        self.actionManagement!.interactionDelegate = self
        
        skJoystick.addChild(self.joystick!)
        skButtons.addChild(self.actionManagement!)
        
        for p in players {
            p.removeFromParent()
            p.position = CGPointMake(-160, -96)
            self.map!.addChild(p)
        }
        
        let bellatrix = map!.childNodeWithName("SKBellatrix") as! SKSpriteNode
        bellatrix.texture!.filteringMode = .Nearest
    }
    
    //MARK: Touch Event's
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
//        if self.movementManagement!.player.menuHasOpened && equipMenu != nil {
//            equipMenu.touchesBegan(touches, withEvent: event)
//        }
        
        if !self.movementManagement!.player.inDialog {
            self.joystick!.touchesBegan(touches, withEvent: event)
        }
        
        self.actionManagement!.touchesBegan(touches, withEvent: event)
        
        for touch in touches {
            
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            if node.name == self.currentPlayer!.name && !self.movementManagement!.player.menuHasOpened {
                
                self.movementManagement!.player.touchesBegan(touches, withEvent: event)
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.joystick!.touchesMoved(touches, withEvent: event)
        self.actionManagement!.touchesMoved(touches, withEvent: event)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.locationInNode(self)
            
            let node = self.nodeAtPoint(location)
            
            if node.name == "btnBack" || node.name == "btnAction" || node.name == "btnSwitch" {
                self.actionManagement!.touchesEnded(touches, withEvent: event)
            }else if !self.movementManagement!.player.inDialog {
                self.joystick!.touchesEnded(touches, withEvent: event)
            }
        }
        
//        if equipMenu != nil {
//            equipMenu.touchesEnded(touches, withEvent: event)
//        }
//        
//        if self.currentDialog != nil {
//            self.currentDialog!.velocity = 0.1
//        }
    }
    
    //MARK: Update Method
    override func update(currentTime: NSTimeInterval) {
        
        if !self.movementManagement!.player.menuHasOpened {
            self.joystick!.update(currentTime)
            self.actionManagement!.update(currentTime)
            self.movementManagement!.update(currentTime, didCollide: false)
        }
        
        let posPlayer = self.movementManagement!.player.position
        let framePlayer = self.movementManagement!.player.position
        
        if (posPlayer.x <= -150 && (posPlayer.y <= 32 && posPlayer.y >= -96)) && self.joystick!.direction == DirectionPlayer.Left {
            
            let transition = SKTransition.fadeWithDuration(0.5)
            
            (self.view as! NavigationController).GoBack(transition)
        }
    }
    
    //MARK: Interaction Delegate
    func interaction() {
        
    }
    
    func runningDialog() {
        
    }
}
