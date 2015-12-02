//
//  CastleScene.swift
//  MiraadTales
//
//  Created by Rodolfo José on 24/11/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import SpriteKit

class CastleScene: SKScene, InteractionDelegate, SKPhysicsContactDelegate {

    var joystick: Joystick!
    var actionManagement: ActionManagement!
    var movementManagement: MovementManagement!
    var players: [Player]!
    var currentPlayer: Player!
    var map: SKNode!
    
    var bodyPlayer: SKPhysicsBody?
    var bodyEnemy: SKPhysicsBody?
    
    var currentDialog: Dialog?
    
    override func didMoveToView(view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
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
        
        if self.bodyPlayer == nil || self.bodyEnemy == nil {
            return
        }
        
        let posPlayer = self.bodyPlayer!.node!.position
        let posTarget = self.bodyEnemy!.node!.position
        
        let x = posPlayer.x - posTarget.x
        let y = posPlayer.y - posTarget.y
        
        let powX = pow(x, 2)
        let powY = pow(y, 2)
        
        let distance = sqrt(powX + powY)
        
        let limiar = (self.bodyPlayer!.node!.frame.width / 2) + (self.bodyEnemy!.node!.frame.width / 2)
        
        if distance > (limiar + 5) {
            print("retornou")
            return
        }
        
        let name = self.bodyEnemy!.node!.name
        
        if name == "SKRohan" && self.currentDialog == nil { /* mudar valores para bellatrix */
            let rohan = DBPlayers.getBard(self.view!)
            
            self.currentDialog = DBInteraction.getInteraction(rohan, player: self.movementManagement!.player, size: CGSizeMake(500, 200))
            self.setupDialog()
            showDialog(self.currentDialog!)
        }
    }
    
    func runningDialog() {
        
    }
    
    private func setupDialog() {
        
        self.currentDialog!.backgroundDialog = true
        self.currentDialog!.zPosition = 30
        
        let skJoystick = self.camera!.childNodeWithName("SKJoystick")!
        let skButtons = self.camera!.childNodeWithName("SKButtons")!
        
        let positionInit = (skJoystick.position.x + (skJoystick.frame.width / 2))
        let positionEnd = (skButtons.position.x - (skButtons.frame.width / 2))
        
        self.currentDialog!.position = CGPointMake((positionInit + positionEnd) / 2, 0)
        
        self.camera!.addChild(self.currentDialog!)
    }
    
    func showDialog(dialog: Dialog) {
        
        if !dialog.isEmpty {
            self.movementManagement!.player.inDialog = true
            self.currentDialog!.changeMessage = true
        }else if dialog.ended {
            self.movementManagement!.player.inDialog = false
            self.currentDialog!.removeFromParent()
            self.currentDialog = nil
            
            if self.bodyEnemy != nil {
                
                if self.bodyEnemy!.node!.name == "SKRohan" { /* mudar valores para bellatrix */
                    let rohan = DBPlayers.getBard(self.view!)
                    let equips = DBEquipSkill.getEquips(PlayersRace.Bard)
                    let skills = [DBEquipSkill.getSkill("Instrument Hit"), DBEquipSkill.getSkill("Power Chord"), DBEquipSkill.getSkill("Dark Sonata")]
                    rohan.alpha = 0.7
                    rohan.race.equipments = equips
                    rohan.race.skills = skills
                    self.players.append(rohan)
                    rohan.position = self.bodyEnemy!.node!.position
                    rohan.zPosition = self.currentPlayer!.zPosition - 1
                    rohan.removePhysicsBodyPlayer()
                    map!.addChild(rohan)
                    
                    self.movementManagement!.addNewPlayer(rohan)
                    
                    self.bodyEnemy!.node!.removeFromParent()
                }
                
                self.bodyEnemy = nil
            }
        }
    }
}
