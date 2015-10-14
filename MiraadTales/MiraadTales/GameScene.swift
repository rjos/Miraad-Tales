//
//  GameScene.swift
//  MiraadTales
//
//  Created by Rodolfo José on 05/10/15.
//  Copyright (c) 2015 Rodolfo José. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var isWalking = false
    var players = [Player]()
    var currentPlayer = 0
    var lastedPositionPlayers: [CGPoint] = []
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
//        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
//        myLabel.text = "Hello, World!";
//        myLabel.fontSize = 45;
//        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
//        
//        self.addChild(myLabel)
        
        let status = PlayerStatus(HP: 12, MP: 6, Speed: 16, pAtk: 16, mAtk: 6, pDef: 12, mDef: 6)
        let ylla = Swordsman(name: "Ylla", status: status, equipments: [Equip](), skills: [Skill](), isDie: false)
        
        let player = Player(race: ylla, imageNamed: "Ylla-2")
        player.name = "ylla"
        self.addChild(player)
        
        lastedPositionPlayers.append(player.position)
        
        let status_hydora = PlayerStatus(HP: 12, MP: 6, Speed: 16, pAtk: 16, mAtk: 6, pDef: 12, mDef: 6)
        let hydora = Paladin(name: "Hydora", status: status_hydora, equipments: [Equip](), skills: [Skill](), isDie: false)
        let pHydora = Player(race: hydora, imageNamed: "Hydora-2")
        pHydora.name = "hydora"
        
        pHydora.position = CGPointMake(player.position.x - player.frame.size.width, player.position.y)
        self.addChild(pHydora)
        
        players.append(player)
        players.append(pHydora)
        
        let joyBack = SKSpriteNode(imageNamed: "dpad")
        let joyFront = SKSpriteNode(imageNamed: "joystick")
        
        joyBack.alpha = 0.5
        joyFront.alpha = 0.7
        
        let joystick = Joystick(thumb: joyFront, andBackdrop: joyBack)
        joystick.name = "joystick"
        joystick.position = CGPointMake(-193.161, -132.619)
        
        let camera = self.childNodeWithName("SKCameraNode") as! SKCameraNode
        camera.position = player.position
        camera.addChild(joystick)
        
        //self.addChild(joystick)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            let nodePosition = self.nodeAtPoint(location)
            
            if nodePosition is SKSpriteNode && nodePosition.name == players[currentPlayer].name {
                players[currentPlayer].touchesBegan(touches, withEvent: event)
            }
        }
    }
   
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        players[currentPlayer].touchesEnded(touches, withEvent: event)
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        players[currentPlayer].touchesCancelled(touches, withEvent: event)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        let camera = self.childNodeWithName("SKCameraNode") as! SKCameraNode
        let joystick = camera.childNodeWithName("joystick") as! Joystick
        
        players[currentPlayer].update(currentTime)
        
        if !self.isWalking && joystick.isTracking && joystick.velocity != CGPointZero {
            
            self.isWalking = !self.isWalking
            
            if joystick.angularVelocity > 1 && joystick.angularVelocity < 2 {
                players[currentPlayer].walkingPlayer(DirectionPlayer.Right)
                players[currentPlayer + 1].walkingPlayer(DirectionPlayer.Right)
            }else if joystick.angularVelocity < -1 && joystick.angularVelocity > -2 {
                players[currentPlayer].walkingPlayer(DirectionPlayer.Left)
                players[currentPlayer + 1].walkingPlayer(DirectionPlayer.Left)
            }else if joystick.angularVelocity > -1 && joystick.angularVelocity < 1 {
                players[currentPlayer].walkingPlayer(DirectionPlayer.Up)
                players[currentPlayer + 1].walkingPlayer(DirectionPlayer.Up)
            }else if joystick.angularVelocity < -2 || joystick.angularVelocity > 2 {
                players[currentPlayer].walkingPlayer(DirectionPlayer.Down)
                players[currentPlayer + 1].walkingPlayer(DirectionPlayer.Down)
            }
            
            var lastedPositionPlayer = players[currentPlayer].position
            lastedPositionPlayers[0] = lastedPositionPlayer
            lastedPositionPlayer = CGPointMake(lastedPositionPlayer.x + (joystick.velocity.x / 10), lastedPositionPlayer.y + (joystick.velocity.y / 10))
            
            players[currentPlayer].position = lastedPositionPlayer
            players[currentPlayer + 1].position = CGPointMake(lastedPositionPlayers[0].x - players[currentPlayer].frame.width, lastedPositionPlayers[0].y)
        }
        
        if !joystick.isTracking {
            
            self.isWalking = false
            players[currentPlayer].removeAction()
            players[currentPlayer + 1].removeAction()
        }
        
        camera.position = players[currentPlayer].position
    }
}
