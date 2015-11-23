//
//  Start.swift
//  MiraadTales
//
//  Created by Rodolfo José on 23/11/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import SpriteKit

class Start: SKScene {

    // Sky
    var bgNode : SKSpriteNode!
    var bgNodeNext : SKSpriteNode!
    var logo: SKSpriteNode!
    
    // Tap Button
    var labelButton: SKLabelNode!
    
    // Time of last frame
    var lastFrameTime : NSTimeInterval = 0
    
    // Time since last frame
    var deltaTime : NSTimeInterval = 0
    
    override func didMoveToView(view: SKView) {
        
        bgNode = self.childNodeWithName("SKStartBg") as! SKSpriteNode
        labelButton = bgNode.childNodeWithName("SKTapStart") as! SKLabelNode
        logo = bgNode.childNodeWithName("SKLogo") as! SKSpriteNode
        
        //Action logo
        let moveUpAction = SKAction.moveTo(CGPointMake(logo.position.x, logo.position.y + 10), duration: 2)
        let moveDownAction = SKAction.moveTo(CGPointMake(logo.position.x, logo.position.y - 10), duration: 2)
        
        let sequenceLogo = SKAction.sequence([moveUpAction, moveDownAction])
        
        self.logo.runAction(SKAction.repeatActionForever(sequenceLogo))
        
        //Action label
        let fadeInAction = SKAction.fadeAlphaTo(0, duration: 0.5)
        let fadeOutAction = SKAction.fadeAlphaTo(1, duration: 0.8)
        
        let sequenceLabel = SKAction.sequence([fadeInAction, fadeOutAction])
        
        self.labelButton.runAction(SKAction.repeatActionForever(sequenceLabel))
    }
    
    //MARK: Touch Event's
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //Open Menu Ep.
        
        let introScene = Intro(fileNamed: "Intro")
        let transition = SKTransition.fadeWithDuration(1)
        
        (self.view as! NavigationController).Navigate(introScene!, transition: transition)
    }
    
    //MARK: Parallax method
    func moveSprite(sprite : SKSpriteNode,
        nextSprite : SKSpriteNode, speed : Float) -> Void {
            var newPosition = CGPointZero
            
            // For both the sprite and its duplicate:
            for spriteToMove in [sprite, nextSprite] {
                
                // Shift the sprite leftward based on the speed
                newPosition = spriteToMove.position
                newPosition.x -= CGFloat(speed * Float(deltaTime))
                spriteToMove.position = newPosition
                
                // If this sprite is now offscreen (i.e., its rightmost edge is
                // farther left than the scene's leftmost edge):
                if spriteToMove.frame.maxX < self.frame.minX {
                    
                    // Shift it over so that it's now to the immediate right
                    // of the other sprite.
                    // This means that the two sprites are effectively
                    // leap-frogging each other as they both move.
                    spriteToMove.position =
                        CGPoint(x: spriteToMove.position.x +
                            spriteToMove.size.width * 2,
                            y: spriteToMove.position.y)
                }
                
            }
    }
    
    //MARK: Update Method
    override func update(currentTime: NSTimeInterval) {
        
        if lastFrameTime <= 0 {
            lastFrameTime = currentTime
        }
        
        // Update delta time
        deltaTime = currentTime - lastFrameTime
        
        // Set last frame time to current time
        lastFrameTime = currentTime
        
        // Next, move each of the four pairs of sprites.
        // Objects that should appear move slower than foreground objects.
        //self.moveSprite(bgNode!, nextSprite:bgNodeNext!, speed:25.0)
    }
}
