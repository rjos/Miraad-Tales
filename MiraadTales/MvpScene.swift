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
    
    var equipMenu: EquipmentsMenu! = nil
    
    var positionManagement: PositionManagement!
    
    var goback = false
    
    override func didMoveToView(view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        self.map = self.childNodeWithName("SKBg")!
        
        if self.userData != nil && (self.userData!["GoBack"] as! Bool) {
            self.loadData()
            self.bodyPlayer = nil
            self.userData!["GoBack"] = false
            
            goback = true
            
            self.setPositionPlayer()
            self.setPositionCamera()
            
            self.currentPlayer!.setPhysicsBodyPlayer(self.currentPlayer!.texture!)
            
            for p in self.players {
                p.removeFromParent()
                p.setPlayerForExploration()
                p.race.status.currentHP = p.race.status.HP
                p.race.status.currentMP = p.race.status.MP
                map!.addChild(p)
            }
            
            if (self.userData!["CombatScene"] as! Bool) {
                if (self.userData!["Win"] as! Bool) {
                    let nodeEnemy = self.bodyEnemy!.node!
                    nodeEnemy.removeFromParent()
                }
            }
            
            let openDoorDown = map!.childNodeWithName("openedDoorDown")
            
            if openDoorDown != nil {
                openDoorDown!.zPosition = 20
            }
            
            let skJoystick = self.camera!.childNodeWithName("SKJoystick")!
            skJoystick.removeAllChildren()
            
            let skButtons = self.camera!.childNodeWithName("SKButtons")!
            skButtons.removeAllChildren()
            
        }else {
            
            positionManagement = PositionManagement()
            
            self.currentPlayer = DBPlayers.getPaladin(self.view!)
            self.players = [self.currentPlayer!]
            
            self.currentPlayer!.race.equipments.append(DBEquipSkill.getEquip("Sledgehammer"))
            self.currentPlayer!.race.equipments[0].baseEquip.isEquipped = true
            self.currentPlayer!.race.skills.append(DBEquipSkill.getSkill("Hammer Hit"))
            
            //self.currentPlayer!.position = CGPointMake(-733.932, 286.614)
            self.currentPlayer!.position = CGPointMake(-433.932, 286.614)
            //self.currentPlayer!.position = CGPointMake(96.715, -287.777)
            
            let rohan = map!.childNodeWithName("SKRohan") as! SKSpriteNode
            rohan.texture!.filteringMode = .Nearest
            
            self.map!.addChild(self.currentPlayer!)
        }
        
        self.joystick = Joystick()
        
        self.movementManagement = MovementManagement(player: self.currentPlayer!, camera: self.camera!, sizeMap: self.map!.frame, joystick: self.joystick!, players: self.players)
        
        self.actionManagement = ActionManagement(imageNamedButtonA: "A", imageNamedButtonB: "B", imageNamedButtonSwitch: "switch", movementManagement: self.movementManagement)
        self.actionManagement!.interactionDelegate = self
        
        let skJoystick = self.camera!.childNodeWithName("SKJoystick")!
        skJoystick.addChild(self.joystick!)
        
        let skButtons = self.camera!.childNodeWithName("SKButtons")!
        skButtons.addChild(self.actionManagement!)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if self.movementManagement!.player.menuHasOpened && equipMenu != nil {
            equipMenu.touchesBegan(touches, withEvent: event)
            return
        }
        
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
        
        if equipMenu != nil {
            equipMenu.touchesEnded(touches, withEvent: event)
            
            if equipMenu.isClosed {
                equipMenu = nil
            }
        }
        
        if self.currentDialog != nil {
            self.currentDialog!.velocity = 0.1
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        
        let posPlayer = self.movementManagement!.player.position
        let framePlayer = self.movementManagement!.player.frame
        
        if (posPlayer.x >= (736.222 + (framePlayer.width / 2) + 10)  && (posPlayer.y <= -217 && posPlayer.y >= -287.98)) && self.joystick!.direction == DirectionPlayer.Right{
            
            self.saveData()
            
            let castleScene = CastleScene(fileNamed: "CastleScene")!
            castleScene.joystick = self.joystick
            castleScene.actionManagement = self.actionManagement
            castleScene.movementManagement = self.movementManagement
            castleScene.currentPlayer = self.currentPlayer
            castleScene.players = players
            
            let transition = SKTransition.fadeWithDuration(0.5)
            
            (self.view as! NavigationController).Navigate(castleScene, transition: transition)
        }
        
        if self.currentDialog != nil {
            self.currentDialog!.update(currentTime)
        }
        
        if !self.movementManagement!.player.menuHasOpened {
            self.joystick!.update(currentTime)
            self.actionManagement!.update(currentTime)
            self.movementManagement!.update(currentTime, didCollide: false)
            self.currentPlayer = self.movementManagement!.player
        }else if self.movementManagement!.player.menuHasOpened {
            openHUD()
        }
    }
    
    private func openHUD() {
        
        if self.movementManagement!.player.selectedMenuContext == "Inventário" {
            equipMenu = EquipmentsMenu(players: players, currentPlayer: self.movementManagement!.player, size: self.size, name: "Equipment", typeHUD: TypeHUD.Equip)
            equipMenu.position = (self.camera?.position)!
            equipMenu.xScale = 0.01
            equipMenu.yScale = 0.01
            //                equipMenu.zPosition = 100
            map!.addChild(equipMenu)
            
            equipMenu.open()
        }else if self.movementManagement!.player.selectedMenuContext == "Key" {
            self.movementManagement!.player.usingItem = self.movementManagement!.player.selectedMenuContext
            self.movementManagement!.player.menuHasOpened = false
        }
        
        self.movementManagement!.player.selectedMenuContext = nil
        
    }
    
    var contato = 1
    
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
        
        if name == "SKRohan" && self.currentDialog == nil {
            let rohan = DBPlayers.getBard(self.view!)
            
            self.currentDialog = DBInteraction.getInteraction(rohan, player: self.movementManagement!.player, size: CGSizeMake(500, 200))
            self.setupDialog()
            showDialog(self.currentDialog!)
        }else if self.movementManagement!.player.inDialog {
            showDialog(self.currentDialog!)
        }else if name == "SKDoor" {
            /*Animated open the door*/
            if self.movementManagement!.player.usingItem == "Key" {
                let newDoor: SKSpriteNode = self.bodyEnemy!.node!.copy() as! SKSpriteNode
                newDoor.name = "OpenDoor"
                
                self.currentDialog = DBInteraction.getInteraction(newDoor, player: self.movementManagement!.player, size: CGSizeMake(500,200))
            }else {
                self.currentDialog = DBInteraction.getInteraction(self.bodyEnemy!.node!, player: self.movementManagement!.player, size: CGSizeMake(500,200))
            }
            
            self.setupDialog()
            showDialog(self.currentDialog!)
            
        }else if name == "SKKey" {
            /*Get key*/
            let key = VLDContextSheetItem(title: "Key", image: UIImage(named: "key"), highlightedImage: UIImage(named: "key"))
            self.movementManagement!.player.setItemIntoMenu(key)
            
            self.currentDialog = DBInteraction.getInteraction(self.bodyEnemy!.node!, player: self.movementManagement!.player, size: CGSizeMake(500,200))
            self.setupDialog()
            showDialog(self.currentDialog!)
        }else if name!.containsString("Zumbi") {
            /*Combat scene*/
            
            let range = name!.characters.count - 1
            
            let qtdade = Int(name![range...range])
            
            let enemies = DBEnemy.getEnemy(name![0...(range - 2)], qtdade: qtdade!)
            
            self.currentPlayer!.removePhysicsBodyPlayer()
            saveData()
            openCombatScene(enemies)
        }
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
    
    func runningDialog() {
        
        if self.currentDialog != nil {
            self.currentDialog!.velocity = 0.03
        }
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
                
                if self.bodyEnemy!.node!.name == "SKKey" {
                    self.bodyEnemy!.node!.removeFromParent()
                    
                }else if self.bodyEnemy!.node!.name == "SKDoor" && self.movementManagement!.player.usingItem == "Key" {
                    let skDoor = self.bodyEnemy!.node!
                    
                    let doorUp = SKSpriteNode(imageNamed: "openedDoorUp")
                    doorUp.zPosition = self.currentPlayer!.zPosition - 5
                    doorUp.position = skDoor.position
                    
                    let doorDown = SKSpriteNode(imageNamed: "openedDoorDown")
                    doorDown.zPosition = self.movementManagement!.player.zPosition + 3
                    doorDown.position = skDoor.position
                    doorDown.name = "openedDoorDown"
                    
                    skDoor.removeFromParent()
                    
                    map!.addChild(doorUp)
                    map!.addChild(doorDown)
                }else if self.bodyEnemy!.node!.name == "SKRohan" {
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
    
    func openCombatScene(enemies: [Enemy]) {
        
        let node = SKSpriteNode(color: UIColor.whiteColor(), size: UIScreen.mainScreen().applicationFrame.size)
        node.zPosition = 50
        node.position = self.camera!.position
        
        let fadeIn = SKAction.fadeInWithDuration(0.1)
        let fadeOut = SKAction.fadeOutWithDuration(0.1)
        
        let sequence = SKAction.sequence([fadeIn, fadeOut, fadeIn, fadeOut, fadeIn])
        
        node.runAction(sequence) { () -> Void in
            node.removeFromParent()
            
            let combatScene = CombatScene(fileNamed: "CombatScene")!
            combatScene.players = self.players
            combatScene.enimies = enemies
            let transition = SKTransition.fadeWithDuration(0.5)
            combatScene.scaleMode = SKSceneScaleMode.AspectFill
            (self.view! as! NavigationController).Navigate(combatScene, transition: transition)
        }
        
        map!.addChild(node)
    }
    
    func setPositionPlayer() {
        
        let positions = self.positionManagement!.getPositionPlayer()
        
        for var i = 0; i < self.players.count; ++i {
            self.players[i].position = positions[i]
        }
    }
    
    func setPositionCamera() {
        
        let position = self.positionManagement!.getPositionCamera()
        self.camera!.position = position
    }
    
    func loadData() {
        self.positionManagement = self.userData!["positionManagement"] as! PositionManagement
        self.currentPlayer = self.userData!["currentPlayer"] as? Player
        self.players = self.userData!["players"] as! [Player]
        self.camera = self.userData!["camera"] as? SKCameraNode
        self.bodyEnemy = self.userData!["enemy"] as? SKPhysicsBody
    }
    
    func saveData() {
        self.positionManagement!.setPosition(self.players)
        self.positionManagement!.setPosition(self.camera!)
        
        self.userData = NSMutableDictionary()
        
        self.userData!["currentPlayer"] = self.currentPlayer
        self.userData!["players"] = self.players
        self.userData!["camera"] = self.camera
        self.userData!["positionManagement"] = self.positionManagement
        self.userData!["enemy"] = self.bodyEnemy
    }
}
