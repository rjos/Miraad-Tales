//
//  Intro.swift
//  MiraadTales
//
//  Created by Rodolfo José on 18/11/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import SpriteKit

class Intro: SKScene, InteractionDelegate {

    var joystick: Joystick? = nil
    var actionManagement: ActionManagement? = nil
    var currentDialog: Dialog?
    
    var beginDialog: Bool = false
    var startTime: NSTimeInterval = 0.0
    var velocityDialog: NSTimeInterval = 0.2
    
    override func didMoveToView(view: SKView) {
        
        self.playAudio("Prologue")
        
        self.joystick = Joystick()
        
        self.actionManagement = ActionManagement(imageNamedButtonA: "A", imageNamedButtonB: "B", imageNamedButtonSwitch: "switch", movementManagement: nil)
        self.actionManagement!.interactionDelegate = self
        
        let skDialog = self.childNodeWithName("SKDialog")!
        
        self.currentDialog = DBInteraction.getInteraction(CGSizeMake(500, 200), isProlog: true)
        self.currentDialog!.changeMessage = true
        
        skDialog.addChild(self.currentDialog!)
        
        let skJoystick = self.camera!.childNodeWithName("SKJoystick")!
        skJoystick.addChild(self.joystick!)
        
        let skButtons = self.camera!.childNodeWithName("SKButtons")!
        skButtons.addChild(self.actionManagement!)
        

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.actionManagement!.touchesBegan(touches, withEvent: event)
        self.joystick!.touchesBegan(touches, withEvent: event)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.actionManagement!.touchesEnded(touches, withEvent: event)
        self.joystick!.touchesEnded(touches, withEvent: event)
        
        if self.currentDialog != nil {
            self.currentDialog!.velocity = 0.03
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        
        self.joystick!.update(currentTime)
        self.actionManagement!.update(currentTime)
        
        if self.currentDialog != nil {
            self.currentDialog!.update(currentTime)
            
            if self.currentDialog!.isEmpty {
                self.currentDialog!.removeFromParent()
                
                if self.currentDialog!.action == ActionDialog.OpenPage {
                    //Open Page
                    self.stopAudio()
                    
                    let mvpScene = MvpScene(fileNamed: "MvpScene")!
                    let transition = SKTransition.fadeWithDuration(1)
                    
                    (self.view as? NavigationController)!.Navigate(mvpScene, transition: transition)
                }
                
                self.currentDialog = nil
            }
        }
    }
    
    func interaction() {
        
        showDialog(self.currentDialog!)
    }
    
    func runningDialog() {
        
        if self.currentDialog != nil {
            self.currentDialog!.velocity = -100000000
        }
    }
    
    func showDialog(dialog: Dialog) {
        
        if !dialog.isEmpty {
            self.currentDialog!.changeMessage = true
        }
    }
}
