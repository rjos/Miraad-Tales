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
    
    var currentDialog: Dialog?
    
    override func didMoveToView(view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        self.map = self.childNodeWithName("SKBg")!
        
        if self.userData != nil && (self.userData!["GoBack"] as! Bool) {
            self.loadData()
            self.userData!["GoBack"] = false
        }else {
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
            
            self.currentPlayer!.position = CGPointMake(-533.932, 286.614)
            self.map!.addChild(self.currentPlayer!)
        }
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
        
        if self.currentDialog != nil {
            self.currentDialog!.velocity = 0.1
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        
        self.joystick!.update(currentTime)
        self.actionManagement!.update(currentTime)
        self.movementManagement!.update(currentTime, didCollide: false)
        
        if self.currentDialog != nil {
            self.currentDialog!.update(currentTime)
        }
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
        
        if self.currentDialog == nil {
            if self.bodyPlayer != nil && self.bodyEnemy != nil {
                
                let name = self.bodyEnemy!.node!.name
                
                if name == "SKRohan" {
                    let rohan = DBPlayers.getBard(self.view!)
                    
                    self.currentDialog = DBInteraction.getInteraction(rohan, player: self.movementManagement!.player, size: CGSizeMake(500, 200))
                    self.currentDialog!.backgroundDialog = true
                    self.currentDialog!.zPosition = 30
                    self.camera!.addChild(self.currentDialog!)
                    showDialog(self.currentDialog!)
                }
                
                //Open Combat Scene
//                self.saveData()
//                self.openScene([])
            }
        }else {
            //Show Dialog
            showDialog(self.currentDialog!)
        }
    }
    
    func runningDialog() {
        
        if self.currentDialog != nil {
            self.currentDialog!.velocity = 0.05
        }
    }
    
    func showDialog(dialog: Dialog) {
        
        if !dialog.isEmpty {
            self.movementManagement!.player.inDialog = true
            self.currentDialog!.changeMessage = true
        }else {
            self.movementManagement!.player.inDialog = false
            self.currentDialog!.removeFromParent()
            self.currentDialog = nil
        }
    }
    
    func openScene(enemies: [Enemy]) {
        
        let combatScene = CombatScene(fileNamed: "CombatScene")!
        combatScene.players = self.players
        let transition = SKTransition.doorsOpenHorizontalWithDuration(0.5)
        combatScene.scaleMode = SKSceneScaleMode.AspectFill
        (self.view! as! NavigationController).Navigate(combatScene, transition: transition)
    }
    
    func loadData() {
        self.currentPlayer = self.userData!["currentPlayer"] as? Player
        self.players = self.userData!["players"] as! [Player]
        self.actionManagement = self.userData!["actionManagement"] as? ActionManagement
        self.movementManagement = self.userData!["movementManagement"] as? MovementManagement
        self.joystick = self.userData!["joystick"] as? Joystick
        self.bodyPlayer = self.userData!["bodyPlayer"] as? SKPhysicsBody
        self.bodyEnemy = self.userData!["bodyEnemy"] as? SKPhysicsBody
        self.currentDialog = self.userData!["dialog"] as? Dialog
        self.camera = self.userData!["camera"] as? SKCameraNode
    }
    
    func saveData() {
        self.userData = NSMutableDictionary()
        self.userData!["currentPlayer"] = self.currentPlayer
        self.userData!["players"] = self.players
        self.userData!["actionManagement"] = self.actionManagement
        self.userData!["movementManagement"] = self.movementManagement
        self.userData!["joystick"] = self.joystick
        self.userData!["bodyPlayer"] = self.bodyPlayer
        self.userData!["bodyEnemy"] = self.bodyEnemy
        self.userData!["dialog"] = self.currentDialog
        self.userData!["camera"] = self.camera
    }
}
