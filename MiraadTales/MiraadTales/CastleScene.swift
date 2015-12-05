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
        
        self.playAudio("Come and Find Me - B mix")
        
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
        
        let cauldron = map!.childNodeWithName("SKCauldron") as! SKSpriteNode
        cauldron.texture!.filteringMode = .Nearest
        
        let atlasCauldron = SKTextureAtlas(named: "cauldronCastle")
        let countTextures = atlasCauldron.textureNames.count
        
        var textures: [SKTexture] = []
        
        for var i = 0; i < (countTextures / 2); ++i {
            let texture = atlasCauldron.textureNamed("cauldronCastle-\(i+1)")
            textures.append(texture)
        }
        
        let action = SKAction.animateWithTextures(textures, timePerFrame: 0.2, resize: false, restore: false)
        
        cauldron.runAction(SKAction.repeatActionForever(action))
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        var bodyPlayer = contact.bodyA
        var bodyEnemy = contact.bodyB
        
        let node = bodyPlayer.node!
        
        if !node.name!.containsString("ydora") && bodyPlayer.contactTestBitMask != 0 {
            let temp = bodyEnemy
            bodyEnemy = bodyPlayer
            bodyPlayer = temp
        }else if bodyPlayer.contactTestBitMask == 0 {
            return
        }
        
        self.bodyPlayer = bodyPlayer
        self.bodyEnemy = bodyEnemy
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
        if self.currentDialog != nil {
            self.currentDialog!.velocity = 0.03
        }
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
            
            self.stopAudio()
            
            let transition = SKTransition.fadeWithDuration(0.5)
            
            (self.view as! NavigationController).GoBack(transition)
        }
        
        if self.currentDialog != nil {
            self.currentDialog!.update(currentTime)
            
            if self.currentDialog!.isEmpty {
                self.currentDialog!.removeFromParent()
                
                if self.currentDialog!.action == ActionDialog.OpenPage {
                    //Open Page
                    self.stopAudio()
                    
                    let combatScene = CombatScene(fileNamed: "CombatScene")!
                    
                    let bellatrix = DBEnemy.getEnemy("Bellatrix", qtdade: 1)
                    let zumbi = DBEnemy.getEnemy("Zumbi", qtdade: 1)
                    
                    combatScene.typeCombat = "Bellatrix"
                    combatScene.players = self.players
                    combatScene.enimies = [bellatrix[0], zumbi[0]]
                    let transition = SKTransition.fadeWithDuration(1)
                    
                    (self.view as? NavigationController)!.Navigate(combatScene, transition: transition)
                }
                
                self.currentDialog = nil
            }
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
        
        if name == "SKBellatrix" && self.currentDialog == nil { /* mudar valores para bellatrix */
            let bellatrix = DBEnemy.getEnemy("Bellatrix", qtdade: 1)[0]
            
            if self.players.count > 1 {
                
                if self.currentPlayer!.race.name == "Hydora" {
                    self.currentDialog = DBInteraction.getInteraction(bellatrix, player: self.currentPlayer!, player2:players[1], size: CGSizeMake(500, 200))
                }else {
                    self.currentDialog = DBInteraction.getInteraction(bellatrix, player: players[1], player2:self.currentPlayer!, size: CGSizeMake(500, 200))
                }
                
            }else {
                self.currentDialog = DBInteraction.getInteraction(bellatrix, player: self.currentPlayer!, size: CGSizeMake(500, 200))
            }
            self.setupDialog()
            showDialog(self.currentDialog!)
        }else if self.movementManagement!.player.inDialog {
            showDialog(self.currentDialog!)
        }
    }
    
    func runningDialog() {
        
        if self.currentDialog != nil {
            self.currentDialog!.velocity = 0
        }
    }
    
    private func setupDialog() {
        
        self.currentDialog!.backgroundDialog = true
        self.currentDialog!.zPosition = 30
        
        let skJoystick = self.camera!.childNodeWithName("SKJoystick")!
        let skButtons = self.camera!.childNodeWithName("SKButtons")!
        
        let positionInit = (skJoystick.position.x + (skJoystick.frame.width / 2))
        let positionEnd = (skButtons.position.x - (skButtons.frame.width / 2))
        
        self.currentDialog!.position = CGPointMake((positionInit + positionEnd) / 2, (skButtons.position.y + skJoystick.position.y) / 2)
        
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
