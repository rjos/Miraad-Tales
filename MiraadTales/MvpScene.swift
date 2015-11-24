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
            self.userData!["GoBack"] = false
            
            goback = true
            
            self.setPositionPlayer()
            self.setPositionCamera()
            
            self.currentPlayer!.removeFromParent()
            
            let skJoystick = self.camera!.childNodeWithName("SKJoystick")!
            skJoystick.removeAllChildren()
            
            let skButtons = self.camera!.childNodeWithName("SKButtons")!
            skButtons.removeAllChildren()
            
        }else {
            
            positionManagement = PositionManagement()
            
            self.currentPlayer = DBPlayers.getPaladin(self.view!)
            self.players = [self.currentPlayer!]
            
//            self.currentPlayer!.position = CGPointMake(-533.932, 286.614)
            self.currentPlayer!.position = CGPointMake(96.715, -287.777)
            
            let rohan = map!.childNodeWithName("SKRohan") as! SKSpriteNode
            rohan.texture!.filteringMode = .Nearest
        }
        
        self.joystick = Joystick()
        
        self.movementManagement = MovementManagement(player: self.currentPlayer!, camera: self.camera!, sizeMap: self.map!.frame, joystick: self.joystick!, players: self.players)
        
        self.actionManagement = ActionManagement(imageNamedButtonA: "A", imageNamedButtonB: "B", imageNamedButtonSwitch: "switch", movementManagement: self.movementManagement)
        self.actionManagement!.interactionDelegate = self
        
        let skJoystick = self.camera!.childNodeWithName("SKJoystick")!
        skJoystick.addChild(self.joystick!)
        
        let skButtons = self.camera!.childNodeWithName("SKButtons")!
        skButtons.addChild(self.actionManagement!)
        
        self.map!.addChild(self.currentPlayer!)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if self.movementManagement!.player.menuHasOpened && equipMenu != nil {
            equipMenu.touchesBegan(touches, withEvent: event)
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
        
        if node.name!.containsString("ydora") {
            self.bodyPlayer = bodyPlayer
            self.bodyEnemy = bodyEnemy
            return
        }
        
        if (bodyPlayer.contactTestBitMask & CollisionSetUps.Player.rawValue) == CollisionSetUps.Player.rawValue {
            let temp = bodyEnemy
            bodyEnemy = bodyPlayer
            bodyPlayer = temp
        }else if (bodyPlayer.contactTestBitMask & CollisionSetUps.Items.rawValue) == CollisionSetUps.Items.rawValue {
            let temp = bodyEnemy
            bodyEnemy = bodyPlayer
            bodyPlayer = temp
        }else if (bodyPlayer.contactTestBitMask & CollisionSetUps.Buildings.rawValue) == CollisionSetUps.Buildings.rawValue {
            let temp = bodyEnemy
            bodyEnemy = bodyPlayer
            bodyPlayer = temp
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
        
        if distance > limiar {
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
        }else {
            /*Combat scene*/
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
            self.currentDialog!.velocity = 0.05
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
                    
                    self.bodyEnemy = nil
                    
                }else if self.bodyEnemy!.node!.name == "SKDoor" && self.movementManagement!.player.usingItem == "Key" {
                    let skDoor = self.bodyEnemy!.node!
                    
                    let doorUp = SKSpriteNode(imageNamed: "openedDoorUp")
                    doorUp.zPosition = self.movementManagement!.player.zPosition - 3
                    doorUp.position = skDoor.position
                    
                    let doorDown = SKSpriteNode(imageNamed: "openedDoorDown")
                    doorDown.zPosition = self.movementManagement!.player.zPosition + 3
                    doorDown.position = skDoor.position
                    
                    skDoor.removeFromParent()
                    
                    self.bodyEnemy = nil
                    
                    map!.addChild(doorUp)
                    map!.addChild(doorDown)
                }
            }
        }
    }
    
    func openScene(enemies: [Enemy]) {
        
        let combatScene = CombatScene(fileNamed: "CombatScene")!
        combatScene.players = self.players
        let transition = SKTransition.doorsOpenHorizontalWithDuration(0.5)
        combatScene.scaleMode = SKSceneScaleMode.AspectFill
        (self.view! as! NavigationController).Navigate(combatScene, transition: transition)
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
//        self.actionManagement = self.userData!["actionManagement"] as? ActionManagement
//        self.movementManagement = self.userData!["movementManagement"] as? MovementManagement
//        self.joystick = self.userData!["joystick"] as? Joystick
        self.camera = self.userData!["camera"] as? SKCameraNode
    }
    
    func saveData() {
        self.positionManagement!.setPosition(self.players)
        self.positionManagement!.setPosition(self.camera!)
        self.userData = NSMutableDictionary()
        self.userData!["currentPlayer"] = self.currentPlayer
        self.userData!["players"] = self.players
//        self.userData!["actionManagement"] = self.actionManagement
//        self.userData!["movementManagement"] = self.movementManagement
//        self.userData!["joystick"] = self.joystick
        self.userData!["camera"] = self.camera
        self.userData!["positionManagement"] = self.positionManagement
    }
}
