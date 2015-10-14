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
        player.name = "player"
        self.addChild(player)
        
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
        
//        for touch in touches {
//            let location = touch.locationInNode(self)
//            
//            let sprite = SKSpriteNode(imageNamed:"Spaceship")
//            
//            sprite.xScale = 0.5
//            sprite.yScale = 0.5
//            sprite.position = location
//            
//            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
//            
//            sprite.runAction(SKAction.repeatActionForever(action))
//            
//            self.addChild(sprite)
//        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        let camera = self.childNodeWithName("SKCameraNode") as! SKCameraNode
        let joystick = camera.childNodeWithName("joystick") as! Joystick
        
        let player = self.childNodeWithName("player") as! Player
        
        var lastedPositionPlayer = player.position
        lastedPositionPlayer = CGPointMake(lastedPositionPlayer.x + (joystick.velocity.x / 10), lastedPositionPlayer.y + (joystick.velocity.y / 10))
        
        if !self.isWalking && joystick.isTracking && joystick.velocity != CGPointZero {
            
            self.isWalking = !self.isWalking
            
            print(joystick.angularVelocity)
            
            if joystick.angularVelocity > 1 && joystick.angularVelocity < 2 {
                player.walkingPlayer(DirectionPlayer.Right)
            }else if joystick.angularVelocity < -1 && joystick.angularVelocity > -2 {
                player.walkingPlayer(DirectionPlayer.Left)
            }else if joystick.angularVelocity > -1 && joystick.angularVelocity < 1 {
                player.walkingPlayer(DirectionPlayer.Up)
            }else if joystick.angularVelocity < -2 || joystick.angularVelocity > 2 {
                player.walkingPlayer(DirectionPlayer.Down)
            }
        }
        
        if !joystick.isTracking {
            
            self.isWalking = false
            player.removeAction()
        }
        
        player.position = lastedPositionPlayer
        camera.position = player.position
    }
}
