//
//  Mvp.swift
//  MiraadTales
//
//  Created by Rodolfo José on 05/11/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import SpriteKit

class MvpScene: SKScene {
    
    var joystick: Joystick? = nil
    var actionManagement: ActionManagement? = nil
    var movementManagement: MovementManagement? = nil
    var map: SKNode? = nil
    var players: [Player] = []
    var currentPlayer: Player? = nil
    
    override func didMoveToView(view: SKView) {
        
        self.map = self.childNodeWithName("SKBg")!
        
        self.currentPlayer = DBPlayers.getPaladin()
        self.players = [self.currentPlayer!]
        
        self.joystick = Joystick()
        
        self.movementManagement = MovementManagement(player: self.currentPlayer!, camera: self.camera!, sizeMap: self.map!.frame, joystick: self.joystick!, players: self.players)
        
        self.actionManagement = ActionManagement(imageNamedButtonA: "A", imageNamedButtonB: "B", imageNamedButtonSwitch: "switch", movementManagement: self.movementManagement)
        
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
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.joystick!.touchesMoved(touches, withEvent: event)
        self.actionManagement!.touchesMoved(touches, withEvent: event)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.joystick!.touchesEnded(touches, withEvent: event)
        self.actionManagement!.touchesEnded(touches, withEvent: event)
    }
    
    override func update(currentTime: NSTimeInterval) {
        
        self.joystick!.update(currentTime)
        self.actionManagement!.update(currentTime)
        self.movementManagement!.update(currentTime, didCollide: false)
    }
}
