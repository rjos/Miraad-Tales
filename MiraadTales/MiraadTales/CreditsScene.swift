//
//  CreditsScene.swift
//  MiraadTales
//
//  Created by Rodolfo José on 30/11/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import SpriteKit

class CreditsScene: SKScene {
    
    var startY: CGFloat = 0.0
    var lastY: CGFloat = 0.0
    var moveableArea = SKNode()
    
    var isClicked: Bool = false
    var isEnd: Bool = false
    
    override func didMoveToView(view: SKView) {
        // set position & add scrolling/moveable node to screen
        moveableArea = self.childNodeWithName("SKBgMoved")!
    }

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let touch = touches.first!
        let location = touch.locationInNode(self)
        
        startY = location.y
        lastY = location.y
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let touch = touches.first!
        let location = touch.locationInNode(self)
        
        let currentY = location.y
        
        let newY = moveableArea.position.y + ((currentY - lastY))
        
        if newY < -384 {
            moveableArea.position = CGPointMake(0, -384)
        }else if newY > 384 {
            moveableArea.position = CGPointMake(0, 384)
        }else {
            moveableArea.position = CGPointMake(0, newY)
        }
        
        isClicked = true
        isEnd = false
        lastY = currentY
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        isClicked = false
        
        if isEnd {
            let start = Start(fileNamed: "Start")!
            let transition = SKTransition.fadeWithDuration(1)
            
            (self.view as! NavigationController).Navigate(start, transition: transition)
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        
        if moveableArea.position.y >= 384 {
            moveableArea.removeAllActions()
            
            let label = moveableArea.childNodeWithName("labelEnd")
            
            if label == nil {
                let labelEnd = SKLabelNode(text: "Back to the Start")
                labelEnd.name = "labelEnd"
                labelEnd.fontName = "Prospero-Bold-NBP"
                labelEnd.fontSize = 48
                labelEnd.fontColor = UIColor(red: 0.96, green: 0.79, blue: 0.45, alpha: 1)
                labelEnd.zPosition = 5
                labelEnd.verticalAlignmentMode = .Top
                labelEnd.horizontalAlignmentMode = .Center
                labelEnd.position = CGPointMake(0, -(moveableArea.frame.size.height / 2) + labelEnd.frame.size.height + 40)
                
                let fadeIn = SKAction.fadeInWithDuration(0.2)
                let fadeOut = SKAction.fadeOutWithDuration(0.2)
                
                let sequence = SKAction.sequence([fadeIn, fadeOut, fadeIn])
                
                labelEnd.runAction(SKAction.repeatActionForever(sequence))
                
                moveableArea.addChild(labelEnd)
            }
            
            isEnd = true
            
        }else if !isClicked {
            
            let nextPoition = CGPointMake(0, moveableArea.position.y + 5)
            
            let action = SKAction.moveTo(nextPoition, duration: 0.1)
            moveableArea.runAction(action)
            
            moveableArea.position = nextPoition
        }
    }
}
