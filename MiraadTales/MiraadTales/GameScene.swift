//
//  GameScene.swift
//  MiraadTales
//
//  Created by Rodolfo José on 05/10/15.
//  Copyright (c) 2015 Rodolfo José. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var isWalking = false
    var players = [Player]()
    var positionCurrentPlayer: CGPoint = CGPointZero
    var lastedPositionPlayers: [CGPoint] = []
    var map: SKNode! = nil
    var movementManagement: MovementManagement! = nil
    var actionManagement: ActionManagement! = nil
    var joystick: Joystick! = nil
    var didCollide:Bool = false

    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
//        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
//        myLabel.text = "Hello, World!";
//        myLabel.fontSize = 45;
//        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
//        
//        self.addChild(myLabel)
//        let ground = SKSpriteNode(imageNamed: "ground")
//        ground.position = CGPointMake(0, 0)
//        ground.zPosition = 15
//        ground.xScale = 1
//        ground.yScale = 1
//        ground.alpha = 1
//        self.addChild(ground)
        
        map = self.childNodeWithName("SKMap")!
        
        self.physicsWorld.contactDelegate = self
        //Add map
//        let skMap = self.childNodeWithName("SKMap")!
//        skMap.addChild(map)
        
        let frameMap = map.frame
        
        //Add Ylla
        let status = PlayerStatus(HP: 12, MP: 6, Speed: 16, pAtk: 16, mAtk: 6, pDef: 12, mDef: 6)
        let ylla = Swordsman(name: "Ylla", status: status, equipments: [Equip](), skills: [Skill](), isDie: false)
        
        let player = Player(race: ylla, imageNamed: "Ylla-2", viewController: self.view!)
        player.name = "ylla"
        player.zPosition = 15
        player.alpha = 0.7
        player.xScale = 1
        player.yScale = 1
        //player.position = CGPointMake((frameMap.width / 2) - (100), (frameMap.height / 2) - (player.frame.height / 2))
        player.position = CGPointMake(0, 0)
//        player.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "Ylla-2"), size: player.size)
        player.setLastedPosition(true, orientation: Orientation.Horizontal)
        map.addChild(player)
        players.append(player)
        
        positionCurrentPlayer = player.position
        
        
        //Add Hydora
        let hydora = Paladin(name: "Hydora", status: status, equipments: [Equip](), skills: [Skill](), isDie: false)
        let pHydora = Player(race: hydora, imageNamed: "Hydora-2", viewController: self.view!)
        pHydora.name = "hydora"
        pHydora.zPosition = 15
        pHydora.alpha = 0.7
        pHydora.xScale = 1
        pHydora.yScale = 1
        pHydora.position = CGPointMake(player.position.x - player.frame.width, player.position.y)
        pHydora.setLastedPosition(true, orientation: Orientation.Horizontal)
        map.addChild(pHydora)
        players.append(pHydora)
        
        
        //Add NPC Herb
        print("\(pHydora.position.x) e \(pHydora.position.y) ");
        let herb = SKSpriteNode(imageNamed: "Herb_01")
//        herb.position.x = 452
//        herb.position.y = 567.5
        herb.alpha = 1
        herb.yScale = 1
        herb.xScale = 1
        herb.zPosition = 15
        herb.position = CGPointMake(580.5, 567.5)
//        player.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "Ylla-2"), size: player.size)
        self.physicsWorld.gravity = CGVectorMake( 0.0, 0.0 );
//        herb.position = CGPointMake(460, 500.5)
//        player.physicsBody.
        herb.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "Herb_02"), size: herb.size)
        herb.physicsBody?.categoryBitMask = CollisionSetUps.NPC.rawValue
                herb.physicsBody?.collisionBitMask = CollisionSetUps.Player.rawValue
        herb.physicsBody?.contactTestBitMask = CollisionSetUps.Player.rawValue
        herb.physicsBody?.allowsRotation = false
        herb.physicsBody?.dynamic = false

        map.addChild(herb)
        
        let joyBack = SKSpriteNode(imageNamed: "dpad")
        let joyFront = SKSpriteNode(imageNamed: "joystick")
        
        joyBack.alpha = 0.5
        joyFront.alpha = 0.7
        
        self.joystick = Joystick()
        joystick.name = "Joystick"
        joystick.xScale = 0.25
        joystick.yScale = 0.25
        joystick.position = CGPointMake(0, 0)
        
        let skJoystick = self.camera!.childNodeWithName("SKJoystick")!
        self.camera!.position = CGPointMake(0,0)
        joystick.zPosition = 15
        skJoystick.addChild(joystick)
        
        self.movementManagement = MovementManagement(player: player, camera: self.camera!, sizeMap: frameMap,joystick: joystick, players: players)
        

        let skButtons = self.camera!.childNodeWithName("SKButtons")!
        self.actionManagement =  ActionManagement(imageNamedButtonA: "A", imageNamedButtonB: "B", imageNamedButtonSwitch: "switch", movementManagement: self.movementManagement)
        skButtons.addChild(self.actionManagement)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
          print("collideeeeeeeeee")
        if(contact.bodyA.categoryBitMask == CollisionSetUps.Player.rawValue && contact.bodyB.collisionBitMask == CollisionSetUps.Player.rawValue){
            didCollide = true;
            print(didCollide)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        self.actionManagement!.touchesBegan(touches, withEvent: event)
        self.joystick.touchesBegan(touches, withEvent: event)
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            let nodePosition = self.nodeAtPoint(location)
            
            if nodePosition is SKSpriteNode && nodePosition.name == movementManagement.player.name {
                movementManagement.player.touchesBegan(touches, withEvent: event)
            }else {
                
//                let combatScene = CombatScene(fileNamed: "CombatScene")!
//                combatScene.players = self.players
//                let transition = SKTransition.doorsOpenHorizontalWithDuration(0.5)
//                combatScene.scaleMode = SKSceneScaleMode.AspectFill
//                self.scene!.view?.presentScene(combatScene, transition: transition)
            }
        }
    }
   
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.actionManagement!.touchesEnded(touches, withEvent: event)
        movementManagement.player.touchesEnded(touches, withEvent: event)
        self.joystick.touchesEnded(touches, withEvent: event)
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        self.actionManagement!.touchesCancelled(touches, withEvent: event)
        movementManagement.player.touchesCancelled(touches, withEvent: event)
        joystick.touchesCancelled(touches, withEvent: event)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        self.movementManagement.update(currentTime, didCollide: didCollide)
        // se nao for colisao
        self.joystick.update(currentTime)
        didCollide = false;
        
    }
    
}
