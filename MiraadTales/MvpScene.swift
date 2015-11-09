//
//  Mvp.swift
//  MiraadTales
//
//  Created by Rodolfo José on 05/11/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import SpriteKit

class MvpScene: SKScene, SKPhysicsContactDelegate, InteractionDelegate {
    
    var joystick: Joystick? = nil
    var actionManagement: ActionManagement? = nil
    var movementManagement: MovementManagement? = nil
    var map: SKNode? = nil
    var players: [Player] = []
    var currentPlayer: Player? = nil
    
    var bodyPlayer: SKPhysicsBody?
    var bodyEnemy: SKPhysicsBody?
    
    override func didMoveToView(view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        self.map = self.childNodeWithName("SKBg")!
        
        self.currentPlayer = DBPlayers.getPaladin(self.view!)
        self.players = [self.currentPlayer!]
        
        self.joystick = Joystick()

        self.movementManagement = MovementManagement(player: self.currentPlayer!, camera: self.camera!, sizeMap: self.map!.frame, joystick: self.joystick!, players: self.players)
        
        self.actionManagement = ActionManagement(imageNamedButtonA: "A", imageNamedButtonB: "B", imageNamedButtonSwitch: "switch", movementManagement: self.movementManagement)
        self.actionManagement!.interactionDelegate = self
        
        let skJoystick = self.camera!.childNodeWithName("SKJoystick")!
        skJoystick.addChild(self.joystick!)
        
        let skButtons = self.camera!.childNodeWithName("SKButtons")!
        skButtons.addChild(self.actionManagement!)
        
        self.currentPlayer!.position = CGPointMake(-733.932, 286.614)
        self.map!.addChild(self.currentPlayer!)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.joystick!.touchesBegan(touches, withEvent: event)
        self.actionManagement!.touchesBegan(touches, withEvent: event)
        
        for touch in touches {
            
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            if node.name == self.currentPlayer!.name {
                
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
            }else {
                self.joystick!.touchesEnded(touches, withEvent: event)
            }
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        
        self.joystick!.update(currentTime)
        self.actionManagement!.update(currentTime)
        self.movementManagement!.update(currentTime, didCollide: false)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        var bodyPlayer = contact.bodyA
        var bodyEnemy = contact.bodyB
        
        if bodyPlayer.contactTestBitMask != CollisionSetUps.Player.rawValue {
            let temp = bodyEnemy
            bodyEnemy = bodyPlayer
            bodyPlayer = temp
        }
        
        self.bodyPlayer = bodyPlayer
        self.bodyEnemy = bodyEnemy
    }
    
    func interaction() {
        
        if self.bodyPlayer != nil && self.bodyEnemy != nil {
         
            //Open Combat Scene
            self.openScene([])
        }
    }
    
    func openScene(enemies: [Enemy]) {
        
        let combatScene = CombatScene(fileNamed: "CombatScene")!
        combatScene.players = self.players
        let transition = SKTransition.doorsOpenHorizontalWithDuration(0.5)
        combatScene.scaleMode = SKSceneScaleMode.AspectFill
        (self.view! as! NavigationController).Navigate(combatScene, transition: transition)
    }
}
